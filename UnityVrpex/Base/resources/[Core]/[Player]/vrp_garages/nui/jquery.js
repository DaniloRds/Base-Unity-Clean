$(document).ready(function () {
  let actionContainer = $("#actionmenu");

  window.addEventListener("message", function (event) {
    let item = event.data;
    switch (item.action) {
      case "showMenu":
        updateGarages();
        actionContainer.fadeIn(1000);
        break;

      case "hideMenu":
        actionContainer.fadeOut(500);
        break;

      case "updateGarages":
        updateGarages();
        break;
    }
  });

  document.onkeyup = function (data) {
    if (data.which == 27) {
      sendData("ButtonClick", "exit");
    }
  };
});

const formatarNumero = (n) => {
  var n = n.toString();
  var r = "";
  var x = 0;

  for (var i = n.length; i > 0; i--) {
    r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
    x = x == 2 ? 0 : x + 1;
  }
  return r.split("").reverse().join("");
};

const sendData = (name, data) => {
  $.post(
    "http://vrp_garages/" + name,
    JSON.stringify(data),
    function (datab) {}
  );
};

const updateGarages = () => {
  $.post("http://vrp_garages/myVehicles", JSON.stringify({}), (data) => {
    const nameList = data.vehicles.sort((a, b) => (a.name2 > b.name2 ? 1 : -1));
    $("#garagem").html(`

            ${nameList
              .map(
                (item) => `
							<div class="item" data-item-name="${item.name}">
												<div class="item-img">
												<img src="http://localhost:80/cidade/carros/${item.name}.png" class="img">
												</div>
							                    <div class="item-textt">

													<div class="item-right fontestamanho">${item.name2}</div>
							                    </div>
							                    <div class="item-text">
													<div class="item-rightt">Status Veiculo</div>
													<div class="item-right">Motor: ${item.engine}% | Gasolina: ${item.fuel}%</div>
							                    </div>
							                   <div class="item-text" style="border: 0;">

							                    </div>
							                    <div class="item-text" style="border: 0;">
                                  		<div class="item-title-ipva">IPVA</div>
							                        <div class="item-texttt">Valor: ${item.status}</div>
							                        <div class="item-ipva">Status: ${item.ipva}</div>
							                    </div>

							</div>

            `
              )
              .join("")}
        `);
  });
};

$(document).on("click", ".item", function () {
  let $el = $(this);
  let isActive = $el.hasClass("active");
  $(".item").removeClass("active");
  if (!isActive) $el.addClass("active");
});

$(document).on("click", ".retirar", function () {
  let $el = $(".item.active");
  if ($el) {
    $.post(
      "http://vrp_garages/spawnVehicles",
      JSON.stringify({
        name: $el.attr("data-item-name"),
      })
    );
  }
  sendData("ButtonClick", "exit");
});

$(document).on("click", ".guardar", function () {
  $.post("http://vrp_garages/deleteVehicles", JSON.stringify({}));
  sendData("ButtonClick", "exit");
});

$(document).on("click", ".close", function () {
  sendData("ButtonClick", "exit");
});
