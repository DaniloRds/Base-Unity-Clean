    window.addEventListener('message', function( event ) {
        //Reset html items
        $('#grupos').empty()
        $('#escolhas').empty()
        document.getElementById("playerId").value = ""

        var item = event.data;
        if ( item.conce == true ) {
            $('.container').css('display','block');
            $('.box').css('display','block');
            criarLista(item.data)
        } else if ( item.conce == false ) {
            $('.conteudo').html("");
            $('.container').css("display","none");
            $('.box').css('display','none');
        } 
    })
    
    function criarLista(data) {
        document.getElementById("playerId").value = data[2].toString()

        data[1].forEach( (item, key) => {
            let div = `<div class='grupo' onClick='javasript:atribuir("${key}${item}")' id='${key}${item}' data-value='${item}'>${item}</div>`
            $('#grupos').append(div)
        })
    
        data[0].forEach( (item, key) => {
            let div = `<div class='player' onClick='javasript:atribuir("${key}${item}")' id='${key}${item}' data-value='${item}'>${item}</div>`
            $('#escolhas').append(div)
        })
    }
    
    function atribuir(id) {
        let item = document.getElementById(id)
        if (item.className == "grupo") {
            item.classList.add("player");
            item.classList.remove("grupo");
            $('#escolhas').append(item)
        } else {
            item.classList.add("grupo");
            item.classList.remove("player");
            $('#grupos').append(item)
        }
    }

    $('.btn-info').click(function() {

        let valores = []
        let grupos = $('.player')
        grupos.get().forEach(item => {
            valores.push($(item).data('value'))
        });

        let player = document.getElementById("playerId").value

        Swal.fire({
            title: 'Atenção!',
            text: "Você quer alterar mesmo o grupo do jogador?",
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'YES'
          }).then((result) => {
            if (result.value) {
                $('.container').css("display","none");
                $.post('http://five_setgroup/aceitar', JSON.stringify({valores, player}));
            }
          })
    })
    
    $('.fa-sign-out-alt').click(function() {
        $('.container').css("display", "none");
        $.post('http://five_setgroup/close', JSON.stringify({}));
    })