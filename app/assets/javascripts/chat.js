function chatroom_connect() {
  var source = new EventSource('/chatroom');
  source.addEventListener("message", function(event) {
    $('#chat_window').append("\n"+event.data);
    $('pre').scrollTop($('#chat_window').height()-310);
  });
}

//$(document).ready(chatroom_connect);
$(document).ready(function() {
  $('#message_send').bind('click', message_send);
  $(document).bind('keypress', function(event){
    if(event.keyCode == 13){
      message_send();
    }
  });
});

function message_send(){
  $.post('/message', {'message':$("#chat").val()});
  $("#chat").val("");
}
