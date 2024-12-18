(function($) {
  $.fn.inputFilter = function(inputFilter) {
    return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      }
    });
  };
}(jQuery));

window.lastEvent = "hideMenu";
$(document).ready(function() {
  var actionContainer = $(".inventory-mask, .inventory-content");
  window.addEventListener("message", function(event) {
    var item = event.data;
    lastEvent = item.action;
    switch (item.action) {
      case "showMenu":
        updateMochila();
        actionContainer.fadeIn(500);
        break;

      case "hideMenu":
        actionContainer.fadeOut(500);
        break;

      case "updateMochila":
        updateMochila();
        break;
    }
  });

  document.onkeyup = function(data) {
    if (data.which == 27) {
      $.post("http://vrp_revistar/invClose", JSON.stringify({}), function(datab) {});
    }
  };
});

var requestAjax = (option, itemKey, amount) => {
  $.post(
    "http://vrp_revistar/" + option,
    JSON.stringify({
      item: itemKey,
      amount
    })
  );
}

var templateTrunkChest = (key, amount, image, name, weight, target) => {
  var buttonText = target == 'inventory' ? 'Colocar' : 'Retirar'; 
  var buttonData = target == 'inventory' ? 'storeItem' : 'takeItem'; 
  return `
  <div class="cell" data-item-key="${key}">
    
    <div class="row">
      <span class="amount">${amount}</span>
    </div>
    <div class="row">
      <div class="image" style="background-image: url(http://localhost:80/cidade/inventory/${image}.png)"></div>
    </div>
    <div class="row">
      <div class="name">${name} <i>(${(weight * amount).toFixed(2)}kg)</i></div>
    </div>
  </div>
  `;
}

const formatarNumero = n => {
  var n = n.toString();
  var r = "";
  var x = 0;

  for (var i = n.length; i > 0; i--) {
    r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
    x = x == 2 ? 0 : x + 1;
  }

  return r.split("").reverse().join("");
};

const updateMochila = () => {

  $.post("http://vrp_revistar/requestMochila", JSON.stringify({}), data => {
    const nameList = data.inventario.sort((a, b) => a.name > b.name ? 1 : -1);
    const nameList2 = data.inventario2.sort((a, b) => a.name > b.name ? 1 : -1);
    $('.bag-workspace > .inventory-title').html(`
      Itens Equipados | <dan class="dan">Dinheiro em Mãos: <dindin class="dindin">$<unity class="money"></unity></dindin></dan>
    `);
    $('.trunk-workspace > .inventory-title').html(`
      Itens na Mochila
    `);
    var inventory = nameList.map(
      item => templateTrunkChest(item.key, item.amount, item.index, item.name, item.peso, 'trunk')
    ).join("");
    var trunkchest = nameList2.map(
      item => templateTrunkChest(item.key, item.amount, item.index, item.name, item.peso, 'inventory')
    ).join("");
    
    $(".bag-workspace .row.objects").html(trunkchest);
    $(".trunk-workspace .row.objects").html(inventory);

    // Atualizar valor do dinheiro
    if (data.money !== undefined) {
      $(".money").text(data.money.toLocaleString('pt-BR'));
    }
  });
};

$(document).ready(function() {
  $(document).on('mousedown', '.objects .cell', function(ev){
    if(ev.which == 3) {
      $('.amount-option').hide();
      $(this).find('.amount-option').show();
    }
  });

  $('body').on('click', function(e) {
    if (!$(e.target).is(".objects .cell").length) {
      $(".cell .options").hide();
    }
  });

  $(document).on('click', '.amount-option button', function() {
    var event = $(this).data('event');
    if(event == 'send') {
      var paramUrl = $(this).data('url');
      console.log(paramUrl);
      var $el = $(this).closest('.cell');
      var amount = Number($el.find(".amount-value").val());
      if(!amount || amount == '') {
        amount = 0;
      }
      
      $.post(
        "http://vrp_revistar/" + paramUrl,
        JSON.stringify({
          item: $el.data("item-key"),
          amount
        })
      );
    }

    console.log('button click');

    Option = false;

    $('.amount-option').hide();
  });
});

$(".amount-option .center input").on('focusout blur', function() {
  if($(this).val() < 0) {
    $(this).val('0');
  }
}).inputFilter(function(value) {
  return /^\d*$/.test(value); 
});

$(".amount-option .left").on('click', function() {
  var amountVal = $(this).closest('.cell').find(".amount-option .center input");
  if((parseInt(amountVal.val()) - 1) >= 0) {
    amountVal.val(parseInt(amountVal.val()) - 1);
  }
});

$(".amount-option .right").on('click', function() {
  var amountVal = $(this).closest('.cell').find(".amount-option .center input");
  amountVal.val(parseInt(amountVal.val()) + 1);
});