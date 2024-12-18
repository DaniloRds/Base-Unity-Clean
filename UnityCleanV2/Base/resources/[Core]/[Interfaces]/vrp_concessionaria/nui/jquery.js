$(document).ready(function(){
	window.addEventListener("message",function(event){

		$(".kdsakdksa").on("keyup", function () {
			let search = $(this).val().toLowerCase();
			$(".nome-carro").filter(function () {
				$(this).closest(".item-cars").toggle($(this).text().toLowerCase().indexOf(search) > -1)
			});	
		});

		switch(event.data.action){
			case "showMenu":

				var item = event.data

				$("#Pagina-Inicio").show(0);
				$("#pagina-lista").hide(0);
				$("#pagina-viewcar").hide(0);

				$("#nomePersonagem").html(item.nome_player);
				if (item.ok) {
					$("#imagemPersonagem").attr("src", item.imagem_player);
					$("#imagemPersonagem").attr("style", "object-position: -8px;");
				} else {
					$("#imagemPersonagem").attr("src", item.imagem_player);
				}


				$("body").fadeIn(800);

			break;

			case "hideMenu":
				$("body").fadeOut();		
			break;
		}
		
	});

	document.onkeyup = function(data) {
		if (data.which == 27){
			$.post("http://vrp_concessionaria/close");
		}else if(data.key == "Enter"){
			if($("#chat-input").val() != "" && $("#chat-input").val() != " " ){
				enviarChat()
			}
		}
	};
});

function formatMoney(n, c, d, t) {
	c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "", i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
	return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
  }

function closeNui(){
	$.post("http://vrp_concessionaria/close");
}

function Sfechar(){
	$("#pagina-viewcar").hide();
	$("#pagina-lista").hide();
	$("#Pagina-Inicio").hide();
}

function trocarPagina(tipo){

	Sfechar()

	if(tipo == 'inicio'){
		$("#Pagina-Inicio").fadeIn(700);
	}

	if(tipo == 'carro'){
        $("#alugarcarro").show(0);
		$('.overflow-cars').empty()
		listCarros('Carros')
		$("#pagina-lista").fadeIn(700);
	}

	if(tipo == 'antigos'){
        $("#alugarcarro").show(0);
		$('.overflow-cars').empty()
		listAntigos('Antigos')
		$("#pagina-lista").fadeIn(700);
	}

	if(tipo == 'suv'){
        $("#alugarcarro").show(0);
		$('.overflow-cars').empty()
		listSuv('Suv')
		$("#pagina-lista").fadeIn(700);
	}

	if(tipo == 'esportivos'){
        $("#alugarcarro").show(0);
		$('.overflow-cars').empty()
		listSport('Esportivos')
		$("#pagina-lista").fadeIn(700);
	}

	if(tipo == 'moto'){
        $("#alugarcarro").show(0);
		$('.overflow-cars').empty()
		listMoto('Motos')
		$("#pagina-lista").fadeIn(700);
	}

	if(tipo == 'outros'){
        $("#alugarcarro").show(0);
		$('.overflow-cars').empty()
		listOther('Outros Veículos')
		$("#pagina-lista").fadeIn(700);
	}

	if(tipo == 'possuidos'){
		$('.overflow-cars').empty()
		listPossuidos('Possuidos')
		$("#pagina-lista").fadeIn(700);
	}

}

function listPossuidos(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://vrp_concessionaria/consultCarrosList",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.overflow-cars').empty()
		consultCarros.forEach((key,value) => {
			$('.overflow-cars').prepend(`

				<div class="item-cars" onclick="vendercarro(this)" data-k="${key.k}">
					<img class="imagem-carro" src="http://localhost:80/cidade/carros/${key.k}.png" onerror="if (this.src != 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png') this.src = 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png';" alt="">
					<div class="nome-carro"><ss>Possuido</ss> ${key.carro}</div>
					<div class="preço-carro"><i class="fa-duotone fa-boxes fa-beat iconPreco"></i>${key.bau} kg</div>
				</div>

			`)
		});
    });
}

function listCarros(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://vrp_concessionaria/consultCarrosList",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.overflow-cars').empty()
		consultCarros.forEach((key,value) => {

			if (key.tipo == "carro") {
				$('.overflow-cars').prepend(`

					<div class="item-cars" onclick="verCarro(this)" data-k="${key.k}" data-link="${key.link}" data-seguro="${formatMoney(key.seguro)}" data-carro="${key.carro}" data-bau="${key.bau}" data-valor="${formatMoney(key.valor)}" data-valor2="${key.valor2}" data-tipo="${key.tipo}">
						<img class="imagem-carro" src="http://localhost:80/cidade/carros/${key.k}.png" onerror="if (this.src != 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png') this.src = 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png';" alt="">
						<div class="nome-carro"><ss>${key.estoque}</ss> ${key.carro}</div>
						<div class="preço-carro"><i class="fa-duotone fa-tags fa-beat iconPreco"></i>${formatMoney(key.valor)}$</div>
					</div>
		
				`)
			}
		});
    });
}

function listAntigos(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://vrp_concessionaria/consultCarrosList",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.overflow-cars').empty()
		consultCarros.forEach((key,value) => {			
			if (key.tipo == "antigos") {
				$('.overflow-cars').prepend(`

					<div class="item-cars" onclick="verCarro(this)" data-k="${key.k}" data-link="${key.link}" data-seguro="${formatMoney(key.seguro)}" data-carro="${key.carro}" data-bau="${key.bau}" data-valor="${formatMoney(key.valor)}" data-valor2="${key.valor2}" data-tipo="${key.tipo}">
						<img class="imagem-carro" src="http://localhost:80/cidade/carros/${key.k}.png" onerror="if (this.src != 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png') this.src = 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png';" alt="">
						<div class="nome-carro"><ss>${key.estoque}</ss> ${key.carro}</div>
						<div class="preço-carro"><i class="fa-duotone fa-tags fa-beat iconPreco"></i>${formatMoney(key.valor)}$</div>
						<div class="kg-carro"><i class="fa-duotone fa-boxes fa-beat iconPreco"></i>${key.bau} kg</div>
					</div>
		
				`)
			}
		});
    });
}

function listSuv(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://vrp_concessionaria/consultCarrosList",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.overflow-cars').empty()
		consultCarros.forEach((key,value) => {			
			if (key.tipo == "suv") {
				$('.overflow-cars').prepend(`

					<div class="item-cars" onclick="verCarro(this)" data-k="${key.k}" data-link="${key.link}" data-seguro="${formatMoney(key.seguro)}" data-carro="${key.carro}" data-bau="${key.bau}" data-valor="${formatMoney(key.valor)}" data-valor2="${key.valor2}" data-tipo="${key.tipo}">
						<img class="imagem-carro" src="http://localhost:80/cidade/carros/${key.k}.png" onerror="if (this.src != 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png') this.src = 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png';" alt="">
						<div class="nome-carro"><ss>${key.estoque}</ss> ${key.carro}</div>
						<div class="preço-carro"><i class="fa-duotone fa-tags fa-beat iconPreco"></i>${formatMoney(key.valor)}$</div>
						<div class="kg-carro"><i class="fa-duotone fa-boxes fa-beat iconPreco"></i>${key.bau} kg</div>
					</div>
		
				`)
			}
		});
    });
}

function listSport(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://vrp_concessionaria/consultCarrosList",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.overflow-cars').empty()
		consultCarros.forEach((key,value) => {			
			if (key.tipo == "esportivos") {
				$('.overflow-cars').prepend(`

					<div class="item-cars" onclick="verCarro(this)" data-k="${key.k}" data-link="${key.link}" data-seguro="${formatMoney(key.seguro)}" data-carro="${key.carro}" data-bau="${key.bau}" data-valor="${formatMoney(key.valor)}" data-valor2="${key.valor2}" data-tipo="${key.tipo}">
						<img class="imagem-carro" src="http://localhost:80/cidade/carros/${key.k}.png" onerror="if (this.src != 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png') this.src = 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png';" alt="">
						<div class="nome-carro"><ss>${key.estoque}</ss> ${key.carro}</div>
						<div class="preço-carro"><i class="fa-duotone fa-tags fa-beat iconPreco"></i>${formatMoney(key.valor)}$</div>
						<div class="kg-carro"><i class="fa-duotone fa-boxes fa-beat iconPreco"></i>${key.bau} kg</div>
					</div>
		
				`)
			}
		});
    });
}

function listMoto(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://vrp_concessionaria/consultCarrosList",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.overflow-cars').empty()
		consultCarros.forEach((key,value) => {			
			if (key.tipo == "moto") {
				$('.overflow-cars').prepend(`

					<div class="item-cars" onclick="verCarro(this)" data-k="${key.k}" data-link="${key.link}" data-seguro="${formatMoney(key.seguro)}" data-carro="${key.carro}" data-bau="${key.bau}" data-valor="${formatMoney(key.valor)}" data-valor2="${key.valor2}" data-tipo="${key.tipo}">
						<img class="imagem-carro" src="http://localhost:80/cidade/carros/${key.k}.png" onerror="if (this.src != 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png') this.src = 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png';" alt="">
						<div class="nome-carro"><ss>${key.estoque}</ss> ${key.carro}</div>
						<div class="preço-carro"><i class="fa-duotone fa-tags fa-beat iconPreco"></i>${formatMoney(key.valor)}$</div>
						<div class="kg-carro"><i class="fa-duotone fa-boxes fa-beat iconPreco"></i>${key.bau} kg</div>
					</div>
		
				`)
			}
		});
    });
}


function listOther(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://vrp_concessionaria/consultCarrosList",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.overflow-cars').empty()
		consultCarros.forEach((key,value) => {			
			if (key.tipo == "outros") {
				$('.overflow-cars').prepend(`

					<div class="item-cars" onclick="verCarro(this)" data-k="${key.k}" data-link="${key.link}" data-seguro="${formatMoney(key.seguro)}" data-carro="${key.carro}" data-bau="${key.bau}" data-valor="${formatMoney(key.valor)}" data-valor2="${key.valor2}" data-tipo="${key.tipo}">
						<img class="imagem-carro" src="http://localhost:80/cidade/carros/${key.k}.png" onerror="if (this.src != 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png') this.src = 'https://media.discordapp.net/attachments/623619036462448683/1092963441154723921/160895.png';" alt="">
						<div class="nome-carro"><ss>${key.estoque}</ss> ${key.carro}</div>
						<div class="preço-carro"><i class="fa-duotone fa-tags fa-beat iconPreco"></i>${formatMoney(key.valor)}$</div>
						<div class="kg-carro"><i class="fa-duotone fa-boxes fa-beat iconPreco"></i>${key.bau} kg</div>
					</div>
		
				`)
			}
		});
    });
}

function vendercarro(data){
	$.post("http://vrp_concessionaria/close");
	$.post("http://vrp_concessionaria/venderCarro",JSON.stringify({
		carro : data.dataset.k,
	}), (data) =>{ 
		if(data.retorno == 'done') {
	
		} 
	});
};

function verCarro(data){
	$(".disposi-carro").attr(`src`,"http://localhost:80/cidade/carros/" + data.dataset.k + ".png");
	$("#carroDKsadask").html(data.dataset.carro);
	$("#Tipodsakds").html(data.dataset.tipo);
	$("#bauQuantidade").html(data.dataset.bau + 'KG');
	$("#valorSeguro").html(data.dataset.seguro + '$');
	$(".Kdsads").html(data.dataset.valor + '$');
	$("#pagina-lista").hide();
	$.post("http://vrp_concessionaria/verCarros",JSON.stringify({
		carro : data.dataset.k,
	}), (data) =>{ 
		if(data.retorno == 'done') {
			$("#rua").html(data.street);
			$("#pagina-viewcar").fadeIn(700);
		} 
	});
};


function testDrive(){
	$.post("http://vrp_concessionaria/testeDrive");
}

function comprarCarro(){
	let cor = $("#color1").val();
	const red = parseInt(cor.substring(1, 3), 16);
	const green = parseInt(cor.substring(3, 5), 16);
	const blue = parseInt(cor.substring(5, 7), 16);
	$.post("http://vrp_concessionaria/comprarCarro",JSON.stringify({
		red:red,
		green:green,
		blue:blue
	}))
}

function alugarcarro(){
	let cor = $("#color1").val();
	const red = parseInt(cor.substring(1, 3), 16);
	const green = parseInt(cor.substring(3, 5), 16);
	const blue = parseInt(cor.substring(5, 7), 16);
	$.post("http://vrp_concessionaria/alugarcarro",JSON.stringify({
		red:red,
		green:green,
		blue:blue
	}))
}

function comprarCarro3(){
	let cor = $("#color1").val();
	const red = parseInt(cor.substring(1, 3), 16);
	const green = parseInt(cor.substring(3, 5), 16);
	const blue = parseInt(cor.substring(5, 7), 16);
	$.post("http://vrp_concessionaria/comprarCarro2",JSON.stringify({
		red:red,
		green:green,
		blue:blue
	}))
}
