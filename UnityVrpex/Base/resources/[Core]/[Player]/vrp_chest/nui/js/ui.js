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

/*$(document).on('contextmenu', function(event) {
    event.preventDefault();
});*/


window.lastEvent = "hideMenu";
$(document).ready(function() {
  var actionContainer = $(".inventory-mask, .inventory-content");
  window.addEventListener("message", function(event) {
    var item = event.data;
    lastEvent = item.action;
    switch (item.action) {
      case "showMenu":
        updateChest();
        actionContainer.fadeIn(500);
        break;

      case "hideMenu":
        actionContainer.fadeOut(500);
        break;

      case "updateChest":
        updateChest();
        break;
    }
  });

  document.onkeyup = function(data) {
    if (data.which == 27) {
      $.post("http://vrp_chest/chestClose", JSON.stringify({}), function(datab) {});
    }
  };

  /*$(".bag-workspace .cell").draggable({
    helper: "clone",
    revert: "invalid",
    start: function(e, ui) {
      $(this).css({'opacity': '0.3', 'cursor': 'move'});
      $('.cell.ui-draggable').find('.options').hide();
      $('.cell.ui-draggable').find('.amount-option').hide();
    },
    helper: function() {
      var helper = $(this).clone();
      helper.css({'width': $(this).width()});
      return helper;
    },
    stop: function(e, ui) {
      $(this).css({'opacity': '1', 'cursor': 'initial'});
    }
  });

  $(".trunk-workspace .objects").droppable({
    accept: ".bag-workspace .cell",
    over: function() {
      $(this).find('.move-here').css({'display': 'flex'}).animate({'opacity': .5});
    },
    out: function() {
      $(this).find('.move-here').animate({'opacity': .0}, 200, function() {
        $(this).css({'display': 'none'});
      });
    },
    drop: function(event, ui) {
      console.log('dropped');
      $(ui.draggable).remove();
      $(this).find('.move-here').animate({'opacity': .0}, 200, function() {
        $(this).css({'display': 'none'});
      });
    }
  });

  $(".trunk-workspace .cell").draggable({
    helper: "clone",
    revert: "invalid",
    start: function(e, ui) {
      $(this).css({'opacity': '0.3', 'cursor': 'move'});
      $('.cell.ui-draggable').find('.options').hide();
      $('.cell.ui-draggable').find('.amount-option').hide();
    },
    helper: function() {
      var helper = $(this).clone();
      helper.css({'width': $(this).width()});
      return helper;
    },
    stop: function(e, ui) {
      $(this).css({'opacity': '1', 'cursor': 'initial'});
    }
  });

  $(".bag-workspace .objects").droppable({
    accept: ".trunk-workspace .cell",
    over: function() {
      $(this).find('.move-here').css({'display': 'flex'}).animate({'opacity': .5});
    },
    out: function() {
      $(this).find('.move-here').animate({'opacity': .0}, 200, function() {
        $(this).css({'display': 'none'});
      });
    },
    drop: function(event, ui) {
      console.log('dropped');
      $(ui.draggable).remove();
      $(this).find('.move-here').animate({'opacity': .0}, 200, function() {
        $(this).css({'display': 'none'});
      });
    }
  });*/
});

var requestAjax = (option, itemKey, amount) => {
  $.post(
    "http://vrp_chest/" + option,
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
    <div class="amount-option">
      <div class="row">
        <div class="left">
          <div class="minus"><i class="fas fa-minus"></i></div>
        </div>
        <div class="center"><input type="text" class="amount-value" placeholder="0" style="border: 0px; outline: 0px; width: 100%; height: 100%; text-align: center; padding-left: 5px; padding-right: 5px;" /></div>
        <div class="right">
          <div class="plus"><i class="fas fa-plus"></i></div>
        </div>
      </div>
      <div class="row">
        <button class="button" data-event="send" data-url="${buttonData}">${buttonText}</button>
      </div>
      <div class="row">
        <button class="button cancel" data-event="cancel">Cancelar</button>
      </div>
    </div>
    <div class="row">
      <span class="amount">${formatarNumero(amount)}</span>
    </div>
    <div class="row">
    <div class="image" style="background-image: url('http://localhost:80/cidade/inventory/${image}.png');"></div>
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
var modalQt = 1;
const updateChest = () => {

  $.post("http://vrp_chest/requestChest", JSON.stringify({}), data => {
    const nameList = data.inventario.sort((a, b) => a.name > b.name ? 1 : -1);
    const nameList2 = data.inventario2.sort((a, b) => a.name > b.name ? 1 : -1);
    $('.bag-workspace > .inventory-title').html(`
      Inventário <small>(<i><b>${data.peso.toFixed(2)}kg</b> em uso <b>${(data.maxpeso - data.peso).toFixed(2)}kg</b> livre de <b>${data.maxpeso.toFixed(2)}kg</b></i> no total)</small>
    `);
    $('.trunk-workspace > .inventory-title').html(`
      Baú <small>(<i><b>${data.peso2.toFixed(2)}kg</b> em uso <b>${(data.maxpeso2 - data.peso2).toFixed(2)}kg </b> livre de <b>${data.maxpeso2.toFixed(2)}kg</b></i> no total)</small>
    `);
    var inventory = nameList.map(
      item => templateTrunkChest(item.key, item.amount, item.index, item.name, item.peso, 'trunk')
    ).join("");
    var trunkchest = nameList2.map(
      item => templateTrunkChest(item.key, item.amount, item.index, item.name, item.peso, 'inventory')
    ).join("");
    
    $(".bag-workspace .row.objects").html(trunkchest);
    $(".trunk-workspace .row.objects").html(inventory);

    $('.amount-value').val(1);
      
    $('.minus').click(() => {
     
        if(modalQt >= 1) {
            modalQt = modalQt - 1;
            $('.amount-value').val(modalQt);
        }
    });
    $('.plus').click(() => {
        modalQt = modalQt + 1;
    
        $('.amount-value').val(modalQt);
    });

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
      var $el = $(this).closest('.cell');
      var amount = Number($el.find(".amount-value").val());
      if(!amount || amount == '') {
        amount = 0;
      }
      
      $.post(
        "http://vrp_chest/" + paramUrl,
        JSON.stringify({
          item: $el.data("item-key"),
          amount
        })
      );
    }

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