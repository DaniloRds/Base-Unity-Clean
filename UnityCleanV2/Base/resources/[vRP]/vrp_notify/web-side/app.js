$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"'>"+event.data.mensagem+"</div>"
		$(html).fadeIn(1000).appendTo("#notifications").delay(5000).fadeOut(1000);
	})
});