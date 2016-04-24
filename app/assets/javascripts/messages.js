$(document).ready(function(){
	$('button#send').click(function(){
		if (!input_is_empty()){
			var URI='/chat/message'
			var message=$('input#chatbox').val();
			var payload = {message:message}
			$.post(URI,payload,function(response)){
				add_message(response);
			});
		});
	$('input#chatbox').val()
});
