$(document).ready(function(){

	window.addEventListener("message",function(event){

		switch(event.data.action){
			case "showMenu":
				$(".container").slideDown(1000);

				$("#level").html(event.data.level);
				$(".dinheiro").html(event.data.money + " $");
				$("#rotasconcluidas").html(event.data.rc);
				$("#exp").html(event.data.exp + "/" + event.data.exp_por_level);

				$("#dinheirorecebido").html("$ 0");
				$("#check").html("0/" + event.data.quantidade_de_blips);

				let value = event.data.exp * 100 / event.data.exp_por_level
				$(".bar1").css("width",value + "%");

			break;

			case "atualizar":

				$("#level2").html(event.data.level);
				$("#dinheirorecebido").html("$ " + event.data.dinheiro_ganho);
				$("#check").html(event.data.checkpoint + "/" + event.data.quantidade_de_blips);
				$(".text-level3").html(event.data.exp + "/" + event.data.exp_por_level);

		

				let value2 = event.data.exp * 100 / event.data.exp_por_level
				$(".bar2").css("width",value2 + "%");

			break;

			case "hideMenu":
				$(".container").slideUp();
				$(".status").fadeOut(1000);		
			break;
		}
		
	});


	document.onkeyup = function(data) {
		if (data.which == 27){
			$.post("http://empFlorestal/Close");
		}
	};
});

$(document).on("click",".iniciar", function() {

		$.post("http://empFlorestal/iniciartrampo",JSON.stringify({
			
		}), (data) =>{ 
			if(data.retorno == 'iniciou') {

				$(".container").slideUp(1000);
				$(".status").fadeIn(1000);
				
				$("#level2").html(data.level);
		
				$(".text-level3").html(data.exp + "/" + data.exp_por_level);

				let valueexp = data.exp * 100 / data.exp_por_level
				$(".bar2").css("width",valueexp + "%");
				
			} 
		});

});
