var limite;
var itensInv = [];
var itensPorta = [];


$(document).ready(function() {
    window.addEventListener("message", function(event) {
        switch (event.data.action) {
            case "showMenu":

                $('#itens').html(''); //LIMPAR SLOTS ANTES DE CRIAR
                updateMochila();
                $("#actionmenu").fadeIn(500);
                $("#passaporte span").html(' ' + event.data.id);
                $("#name b").html(event.data.nome + ' ' + event.data.sobrenome);
                $("#idade span").html(event.data.idade);
                $("#registro span").html(event.data.registro);
                $("#telefone span").html(event.data.telefone);
                $("#job span").html(event.data.job ? event.data.job : "Desempregado" );
                if (event.data.vip == ""){
                    $('#vip z').hide();
                    $("#vip span").hide();
                }else{
                    $('#vip z').show();
                    $("#vip span").show();
                    $("#vip span").html(event.data.vip + " - " + event.data.vipDays + " Dias");
                }
                $("#carteira span").html(event.data.carteira);
                $("#banco span").html(event.data.banco);
                $("#coin span").html(event.data.coin);
                if (event.data.multas == 0){
                    $('#multas z').hide();
                    $("#multas span").hide();
                }else{
                    $('#multas z').show();
                    $("#multas span").show();
                    $("#multas span").html(event.data.multas);
                }
                
                
                modalQt = 0;
            break;

            case "hideMenu":
                $("#actionmenu").fadeOut(500);
            break;

            case "updateMochila":
                updateMochila();
            break;
        }
    });
    $('#fechar').click(() => {
        $.post("http://gbz-inventory/invClose");
        $('#quantidade').hide();
        $('#cursor').hide();

    });
    document.onkeyup = function(data) {
        if(data.which == 27) {
            $.post("http://gbz-inventory/invClose");
            $('#quantidade').hide();

        }
    };
});

const updateDrag = () => {
    var modalQt = 0;
    $('#confirm').off();
    $('#praMenos').click(() => {
        if(modalQt >= 1) {
            modalQt = modalQt - 1;
            $('#placeQt').val(modalQt);
        }
    });
    $('#praMais').click(() => {
        modalQt = modalQt + 1;

        $('#placeQt').val(modalQt);
    });

    $('.item').draggable({
        helper: 'clone',
        appendTo: 'body',
        zIndex: 99999,
        revert: 'invalid',
        opacity: 0.7,
        start: function(event, ui) {
            $(this).children().children('img').hide();
            itemData = {
                key: $(this).data('item-key'),
                type: $(this).data('item-type')
            };
            if(itemData.key === undefined || itemData.type === undefined) return;

            $('.nomeItem').hide();
            $('#botoes').show();

            let $el = $(this);
            $el.addClass("active");
        },
        stop: function() {
            $('#botoes').hide();
            $(this).children().children('img').show();

            let $el = $(this);
            $el.removeClass("active");

        }
    })

    $('.usar').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {

            $('.item').animate({
                top: "0px",
                left: "0px"
            });
            itemData = {
                key: ui.draggable.data('item-key'),
                type: ui.draggable.data('item-type')
            };

            if(itemData.key === undefined || itemData.type === undefined) return;

            $('#quantidade').show();
            $('#placeQt').val(modalQt);
            $('#msgTeste').html('USAR');
            $('#confirm').click(() => {
                $.post("http://gbz-inventory/useItem", JSON.stringify({
                    item: itemData.key,
                    type: itemData.type,
                    amount: Number($("#placeQt").val())

                }))
                $('#quantidade').hide();
            });

            $('#fecharModal').click(() => {
                $('#quantidade').hide();
            });
        }
    })

    $('.dropar').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {

            $('.item').animate({
                top: "0px",
                left: "0px"
            });
            itemData = {
                key: ui.draggable.data('item-key')
            };

            if(itemData.key === undefined) return;
            $('#msgTeste').html('DROPAR');
            $('#quantidade').show();
            $('#placeQt').val(modalQt);
            $('#confirm').click(() => {
                $.post("http://gbz-inventory/dropItem", JSON.stringify({
                    item: itemData.key,
                    amount: Number($("#placeQt").val())
                }))
                $('#quantidade').hide();
            });

            $('#fecharModal').click(() => {
                $('#quantidade').hide();
            });


        }
    })

    $('.enviar').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {

            $('.item').animate({
                top: "0px",
                left: "0px"
            });
            itemData = {
                key: ui.draggable.data('item-key')
            };

            if(itemData.key === undefined) return;
            $('#msgTeste').html('ENVIAR');

            $('#quantidade').show();
            $('#placeQt').val(modalQt);
            $('#confirm').click(() => {

                $.post("http://gbz-inventory/sendItem", JSON.stringify({
                    item: itemData.key,
                    amount: Number($("#placeQt").val())

                }))
                $('#quantidade').hide();
            });

            $('#fecharModal').click(() => {
                $('#quantidade').hide();
            });

        }
    })


    $('#itens').droppable({
        hoverClass: 'hoverControl',
        accept: '.itemBau',
        drop: function(event, ui) {
            itemData = {
                key: ui.draggable.data('item-key')
            };
            if(itemData.key === undefined) return;

            $('#quantidade').show();
            $('#placeQt').val(modalQt);
            $('#msgTeste').html('RETIRAR');
            $('#confirm').click(() => {
                $.post("http://gbz-inventory/takeItem", JSON.stringify({
                    item: itemData.key,
                    amount: Number($("#placeQt").val())
                }))
                $('#quantidade').hide();
            });
        }
    })
}

const formatarNumero = (n) => {
    var n = n.toString();
    var r = '';
    var x = 0;

    for(var i = n.length; i > 0; i--) {
        r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
        x = x == 2 ? 0 : x + 1;
    }

    return r.split('').reverse().join('');
}

const updateMochila = () => {
    $.post("http://gbz-inventory/requestMochila", JSON.stringify({}), (data) => {

        itensInv = data.inventario;
        itensPorta = data.inventario2;
        $('#itens').html(''); //LIMPAR SLOTS ANTES DE CRIAR
        $('#possui').html((data.peso).toFixed(2));
        $('#total').html((data.maxpeso).toFixed(2) + 'kg');

		$('#identidade').css('height', '630px');
        $('#identidade').show();
        $('#bau').hide();
        $('.itemRG').css('margin-top', '40px');
        $('#paypal').css('display', 'block');
        $('#vip').css('display', 'block');

        if(data.maxpeso <= 6){
            $('#peso span').css('width',data.peso * 100/6 +'%');
        }else if(data.maxpeso <= 51){
            $('#peso span').css('width',data.peso * 100/51 +'%');
        }else if(data.maxpeso <= 75){
            $('#peso span').css('width',data.peso * 100/75 +'%');
        }else if(data.maxpeso <= 90){
            $('#peso span').css('width',data.peso * 100/90 +'%');
        }  

        for(let i = 0; i < itensInv.length; i++) { // SETANDO OS SLOTS
            $('#itens').append(`
			<div id="item${i}" class="item itemInv"  style="background-image: url('http://localhost:80/cidade/inventory/${itensInv[i].index}.png'); background-size: 100% 100%; background-position: center;"  data-item-key="${itensInv[i].key}" data-item-type="${itensInv[i].type}" data-name-key="${itensInv[i].name}" class="item"></div>
			`);
            for(let f = 0; f < itensInv.length; f++) {
                $('#item' + f).html(`
					<div id="qtItem">x${formatarNumero(itensInv[f].amount)}</div>
					<div id="nomeItem${f}" class="nomeItem" style="display: none;"><z>${itensInv[f].name}</z></div>
            	`);
                $('#item' + f).hover(() => {
                    $('#hover' + f).show();
                    $('#nomeItem' + f).show();
                });
                $('#item' + f).mouseleave(() => {
                    $('#nomeItem' + f).hide();
                    $('#hover' + f).hide();
                });
            }
        }
       
        updateDrag();
    });
}
$('#cancel').click(() => {
    $('#quantidade').hide();
});

$('#personagem').click(() => {
    $('#parte2, #parte3').show();
    $('#parte6').hide();
    $('#criacao').css('color', '#fff');
    $('#criacao').removeClass('selected');
    $('#personagem').addClass('selected');
    $('#personagem').css('color', '#000');
});