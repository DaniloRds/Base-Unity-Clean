$(document).ready(function(){
	let actionContainer = $("#actionmenu");
	let actionButton = $("#actionbutton");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				actionButton.fadeIn(1000);
				actionContainer.fadeIn(1000);
			break;

			case "hideMenu":
				actionButton.fadeOut(1000);
				actionContainer.fadeOut(1000);
			break;

			case 'updateCarrosvip1':
				updateCarrosVip1();
			break;

			case 'updateCarrosvip2':
				updateCarrosVip2();
			break;

			case 'updateCarrosvip3':
				updateCarrosVip3();
			break;

			case 'updateMotosvip':
				updateMotosVip();
			break;

			case 'updatePacotesVip':
				updatePacotesVip();
			break;

			case 'updateAdicionaisVip':
				updateAdicionaisVip();
			break;

			case 'updatePossuidosvip':
				updatePossuidosVip();
			break;
		}
	});

	$("#inicio").load("./inicio.html");

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_shop_vip/shopClose",JSON.stringify({}),function(datab){});
		}
	};
});

$('#actionbutton').click(function(e){
	$.post("http://vrp_shop_vip/shopClose",JSON.stringify({}),function(datab){});
});

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

const carregarMenu = (name) => {
	return new Promise((resolve) => {
		$("#inicio").load(name+".html",function(){
			resolve();
		});
	});
}

const updateCarrosVip1 = () => {
	$.post("http://vrp_shop_vip/requestCarrosvip1",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="modelContainer">
				<div class="model" data-name-key="${item.k}">
					<div class="image">
					<img style="max-width: 100%; max-height: 132px; width: 890px; height: 470px;" src="http://localhost:80/cidade/lojavip/${item.k}.png" />
					</div>
					<div class="name">${item.nome}</div>
					<div class="alt"><b class="esquerda">Preço:</b> <b class="direita"><img style="width: 14px; height: 14px;"  src="https://i.imgur.com/7s6CFr7.png"/> ${formatarNumero(item.price)}</b></div>
					<div class="alt"><b class="esquerda">Mala:</b> <b class="direita">${item.chest}</b></div>
					<div class="alt"><b class="esquerda">Estoque:</b> <b class="direita">${item.stock}</b></div>
					<div class="comprar">COMPRAR</div>
				</div>
			</div>
			`)).join('')}
		`);
	});
}

const updateCarrosVip2 = () => {
	$.post("http://vrp_shop_vip/requestCarrosvip2",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="modelContainer">
				<div class="model" data-name-key="${item.k}">
					<div class="image">
					<img style="max-width: 100%; max-height: 132px; width: 890px; height: 470px;" src="http://localhost:80/cidade/lojavip/${item.k}.png" />
					</div>
					<div class="name">${item.nome}</div>
					<div class="alt"><b class="esquerda">Preço:</b> <b class="direita"><img style="width: 14px; height: 14px;"  src="https://i.imgur.com/7s6CFr7.png"/> ${formatarNumero(item.price)}</b></div>
					<div class="alt"><b class="esquerda">Mala:</b> <b class="direita">${item.chest}</b></div>
					<div class="alt"><b class="esquerda">Estoque:</b> <b class="direita">${item.stock}</b></div>
					<div class="comprar">COMPRAR</div>
				</div>
			</div>
			`)).join('')}
		`);
	});
}

const updateCarrosVip3 = () => {
	$.post("http://vrp_shop_vip/requestCarrosvip3",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="modelContainer">
				<div class="model" data-name-key="${item.k}">
					<div class="image">
					<img style="max-width: 100%; max-height: 132px; width: 890px; height: 470px;" src="http://localhost:80/cidade/lojavip/${item.k}.png" />
					</div>
					<div class="name">${item.nome}</div>
					<div class="alt"><b class="esquerda">Preço:</b> <b class="direita"><img style="width: 14px; height: 14px;"  src="https://i.imgur.com/7s6CFr7.png"/> ${formatarNumero(item.price)}</b></div>
					<div class="alt"><b class="esquerda">Mala:</b> <b class="direita">${item.chest}</b></div>
					<div class="alt"><b class="esquerda">Estoque:</b> <b class="direita">${item.stock}</b></div>
					<div class="comprar">COMPRAR</div>
				</div>
			</div>
			`)).join('')}
		`);
	});
}

const updateMotosVip = () => {
	$.post("http://vrp_shop_vip/requestMotosVip",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="modelContainer">
				<div class="model" data-name-key="${item.k}">
					<div class="image">
					<img style="max-width: 100%; max-height: 132px; width: 890px; height: 470px;" src="http://localhost:80/cidade/lojavip/${item.k}.png" />
					</div>
					<div class="name">${item.nome}</div>
					<div class="alt"><b class="esquerda">Preço:</b> <b class="direita"><img style="width: 14px; height: 14px;"  src="https://i.imgur.com/7s6CFr7.png"/> ${formatarNumero(item.price)}</b></div>
					<div class="alt"><b class="esquerda">Mala:</b> <b class="direita">${item.chest}</b></div>
					<div class="alt"><b class="esquerda">Estoque:</b> <b class="direita">${item.stock}</b></div>
					<div class="comprar">COMPRAR</div>
				</div>
			</div>
			`)).join('')}
		`);
	});
}

const updateAdicionaisVip = () => {
	$.post("http://vrp_shop_vip/requestAdicionaisVip",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
				<div class="modelContainer">
					<div class="model" data-name-key="${item.k}">
						<div class="image">
						<img style="max-width: 100%; max-height: 132px; width: 890px; height: 470px;" src="http://localhost:80/cidade/lojavip/${item.k}.png" />
						</div>
						<div class="name">${item.nome}</div>
						<div class="alt"><b class="esquerda">Preço:</b> <b class="direita"><img style="width: 14px; height: 14px;"  src="https://i.imgur.com/7s6CFr7.png"/> ${formatarNumero(item.price)}</b></div>
						<div class="comprar">COMPRAR</div>
					</div>
				</div>
			`)).join('')}
		`);
	});
}

const updatePacotesVip = () => {
	$.post("http://vrp_shop_vip/requestPacotesVip",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="modelContainer">
				<div class="model" data-name-key="${item.k}">
					<div class="image">
					<img style="max-width: 100%; max-height: 132px; width: 890px; height: 470px;" src="http://localhost:80/cidade/lojavip/${item.k}.png" />
					</div>
					<div class="name">${item.nome}</div>
					<div class="alt"><b class="esquerda">Preço:</b> <b class="direita"><img style="width: 14px; height: 14px;"  src="https://i.imgur.com/7s6CFr7.png"/> ${formatarNumero(item.price)}</b></div>
					<div class="comprar">COMPRAR</div>
				</div>
			</div>
			`)).join('')}
		`);
	});
}

const updatePossuidosVip = () => {
	$.post("http://vrp_shop_vip/requestPossuidosVip",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="modelContainer">
				<div class="model" data-name-key="${item.k}">
					<div class="image">
					<img style="max-width: 100%; max-height: 132px; width: 890px; height: 470px;" src="http://localhost:80/cidade/lojavip/${item.k}.png" />
					</div>
					<div class="name2">${item.nome}</div>
					<div class="alt"><b class="esquerda">Preço:</b> <b class="direita"><img style="width: 14px; height: 14px;"  src="https://i.imgur.com/pb44970.png"/> ${formatarNumero(item.price)}</b></div>
					<div class="alt"><b class="esquerda">Mala:</b> <b class="direita">${item.chest}</b></div>
					<div class="vender">VENDER</div>
				</div>
			</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".model",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.model').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$(document).on("click",".comprar",function(){
	let $el = $('.model.active');
	if($el){
		$.post("http://vrp_shop_vip/buyShop",JSON.stringify({
			name: $el.attr('data-name-key')
		}));
	}
});

$(document).on("click",".vender",function(){
	let $el = $('.model.active');
	if($el){
		$.post("http://vrp_shop_vip/sellShop",JSON.stringify({
			name: $el.attr('data-name-key')
		}));
	}
});

$(document).on("click",".sair",function(){
	$.post("http://vrp_shop_vip/shopClose",JSON.stringify({}),function(datab){});
});

function botao() {
	$.post("http://vrp_shop_vip/shopClose",JSON.stringify({}),function(datab){});
}
