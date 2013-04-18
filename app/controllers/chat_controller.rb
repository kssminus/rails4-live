class ChatController < ApplicationController
  include ActionController::Live

  def index
    respond_to do |format|
      format.html
    end
  
  end
  
  def message 
    begin
      redis = REDIS_CLIENT 
      if redis.publish('chatroom', params['message'])
        render json: { result: 'ok'}.to_json
      else
        render json: { result: 'error'}.to_json
      end
    rescue  StandardError => msg
      Rails.logger.fatal "Redis publish exception occur"
      Rails.logger.fatal  msg
      
      render json: { result: 'error'}.to_json
    end
  end

  def chatroom 
  
    begin
      response.header['Content-Type'] = "text/event-stream"
      redis = Redis.new
      redis.subscribe('chatroom') do |on|
        on.message do |event, data|
          response.stream.write("data: #{data}\n\n") 
        end
      end
    rescue IOError  => msg
      Rails.logger.fatal msg
    ensure 
      redis.quit
      response.stream.close
    end 
  end

end
