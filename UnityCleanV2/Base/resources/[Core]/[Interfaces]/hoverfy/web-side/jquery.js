$(document).ready(function(){
	window.addEventListener("message",function(event){

		if (event["data"]["show"] == true){
			var key = event["data"]["key"] !== undefined ? "<div id='key'>" + event["data"]["key"] + "</div>":""

			$("#displayNotify").html(key + "<div id='text'><b>" + event["data"]["title"] + "</b><br>" + event["data"]["legend"] + "</div>");
			$("#displayNotify").fadeIn(250);
		}

		if (event["data"]["show"] == false){
			$("#displayNotify").fadeOut(250);
			$("#displayNotify").css("display","none" );
		}

	});
});