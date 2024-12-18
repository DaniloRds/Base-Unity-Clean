$(document).ready(()=>{
    $('.tooltipped').tooltip();
    $(".map-wrapper").on("click",".Sbtn",function(){
        $(".spawn-wrapper").addClass("disabled");
        $(".spawn-box .spawn-name").text($(this).data("info"))
        $(".spawnBtn").data("spawn-name",$(this).data("location"))
        let imagem = $(this).attr("data-location");
        $("#imagem").html("<img src='imagens/"+imagem+".png'>")
        $(".spawn-box").fadeIn(100);
    })
    $.post("http://spawnselector/time")
    window.addEventListener("message",(e)=>{
        if(e.data.action == "display"){
            $.post("http://spawnselector/time")
            $("body").css("background","rgba(0,0,0,0.7)");
            $(".spawn-wrapper").removeClass("disabled");
            $(".spawn-wrapper").fadeIn(500); 
        }
        else if(e.data.action == "dia"){
            $(".map-wrapper").css("background","url(./map.png)");
            $(".map-wrapper").css("top","5%");
            $(".map-wrapper").css("right","3.5%");
            $(".map-wrapper").css("position","relative");
            $(".map-wrapper").css("width","100%");
            $(".map-wrapper").css("height","90%");
            $(".map-wrapper").css("background-size","cover");
            $(".map-wrapper").css("border-radius","50px");
        }
    })
})

function Spawn(){

  var location = $(".spawnBtn").data("spawn-name");
  $.post("http://spawnselector/spawn",JSON.stringify({
      location:location
  }))
  $("body").css("background","transparent");
  $(".spawn-box").fadeOut(100);
  $(".spawn-wrapper").fadeOut(300);
}

function GoBack(){
    $(".spawn-box").fadeOut(350);
    $(".spawn-wrapper").removeClass("disabled");
}