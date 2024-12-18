$(document).ready(function(){
	let actionChest = $("#actionmenu");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				updateChest();
				actionChest.fadeIn(500);
			break;

			case "hideMenu":
				actionChest.fadeOut(500);
			break;

			case "updateChest":
				updateChest();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_trunkchest/chestClose");
		}
	};
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

const updateChest = () => {
	$.post("http://vrp_trunkchest/requestChest",JSON.stringify({}),(data) => {
		const nameList = data.inventario.sort((a,b) => (a.name > b.name) ? 1: -1);
		const nameList2 = data.inventario2.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#inventory').html(`
			<div class="peso"><b>OCUPADO:</b>  ${(data.peso).toFixed(2)}    <s>|</s>    <b>DISPONÍVEL:</b>  ${(data.maxpeso-data.peso).toFixed(2)}    <s>|</s>    <b>TAMANHO:</b>  ${(data.maxpeso).toFixed(2)}</div>
			<div class="peso2"><b>OCUPADO:</b>  ${(data.peso2).toFixed(2)}    <s>|</s>    <b>DISPONÍVEL:</b>  ${(data.maxpeso2-data.peso2).toFixed(2)}    <s>|</s>    <b>TAMANHO:</b>  ${(data.maxpeso2).toFixed(2)}</div>
			<div class="esquerda">
				${nameList2.map((item) => (`
					<div class="item" style="background-image: url('http://localhost:80/cidade/inventory/${item.index}.png');" data-item-key="${item.key}">
						<div id="peso">${(item.peso*item.amount).toFixed(2)}</div>
						<div id="quantity">${formatarNumero(item.amount)}x</div>
						<div id="itemname">${item.name}</div>
					</div>
				`)).join('')}
			</div>

			<div class="meio">
				<input id="amount" class="qtd" maxlength="9" spellcheck="false" value="" placeholder="QUANTIDADE">
				<div class="pegar">RETIRAR</div>
				<div class="guardar">COLOCAR</div>
			</div>

			<div class="direita">
				${nameList.map((item) => (`
					<div class="item2" style="background-image: url('http://localhost:80/cidade/inventory/${item.index}.png');" data-item-key="${item.key}">
						<div id="peso">${(item.peso*item.amount).toFixed(2)}</div>
						<div id="quantity">${formatarNumero(item.amount)}x</div>
						<div id="itemname">${item.name}</div>
					</div>
				`)).join('')}
			</div>
		`);
	});
}

$(document).on("click",".item",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.item').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$(document).on("click",".item2",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.item2').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$(document).on("click",".pegar",function(){
	let $el = $('.item2.active');
	let amount = Number($('#amount').val());
	if($el && amount > 0){
		$.post("http://vrp_trunkchest/takeItem",JSON.stringify({
			item: $el.attr('data-item-key'),
			amount
		}));
	} else if($el){
		$.post("http://vrp_trunkchest/takeItem",JSON.stringify({
			item: $el.attr('data-item-key')
		}));
	}
});

$(document).on("click",".guardar",function(){
	let $el = $('.item.active');
	let amount = Number($('#amount').val());
	if($el && amount > 0){
		$.post("http://vrp_trunkchest/storeItem",JSON.stringify({
			item: $el.attr('data-item-key'),
			amount
		}));
	} else if($el){
		$.post("http://vrp_trunkchest/storeItem",JSON.stringify({
			item: $el.attr('data-item-key')
		}));
	}
})