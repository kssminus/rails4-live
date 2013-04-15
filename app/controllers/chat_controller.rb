class ChatController < ApplicationController
  include ActionController::Live

  def index
    respond_to do |format|
      format.html
    end
  
  end
  
  def message 
    begin
      redis = Redis.new
      if redis.publish('chatroom', params['message'])
        #redis.quit
        render json: { result: 'ok'}.to_json
      else
        render json: { result: 'error'}.to_json
      end
    rescue 
      Rails.logger.fatal "Redis publish exception occur"
    ensure
      redis.quit
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
    rescue IOError
      Rails.logger.fatal IOError.inspect
      redis.quit
    ensure 
      response.stream.close
    end 
  end

end
