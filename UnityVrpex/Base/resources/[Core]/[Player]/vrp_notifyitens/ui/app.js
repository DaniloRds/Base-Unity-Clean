$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "";

		if (event.data.mode == 'sucesso') {
			html = '<div class="fundo" style="border: 1px solid rgba(4, 231, 64, 0.767);" ><div class="fundofalso"><img src="http://localhost:80/cidade/inventory/'+event.data.item+'.png" alt=""></div><div class="fundoimg"></div><br><br><br><br>'
		}

		if (event.data.mode == 'negado') {			
			html = '<div class="fundo" style="border: 1px solid rgba(231, 15, 4, 0.77);"><div class="fundofalso"><img src="http://localhost:80/cidade/inventory/'+event.data.item+'.png" alt=""></div><div class="fundoimg"></div><br><br><br><br>'
		}

		$(html).fadeIn(500).appendTo("#notifyitens").delay(5000).fadeOut(500);
	})
});