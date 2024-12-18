
function setVeloBar(velo) {
    let fill_value = 180 * (velo) / (300)

    let fill_element = document.querySelector('.veloFill')

    fill_element.style.width = `${fill_value}%`
}

$(function () {
    $(document).ready(() => { })
    window.addEventListener('message', function (event) {

        var item = event.data;

        // Progress BAR
        if (item !== undefined && item.type === "ui"){	                
            if (item.display === true) {
                $(".progressBar").show();
                var start = new Date();
                var maxTime = item.time;
                var timeoutVal = Math.floor(maxTime/1000);
                animateUpdate();
      
                function updateProgress(percentage) {
                    $('#pbar_innerdiv').css("width",percentage+"%");
                    $('.tempo').text(timeoutVal);
                }

                function animateUpdate() {
                    var now = new Date();
                    var timeDiff = now.getTime() - start.getTime();
                    var perc = Math.round((timeDiff/maxTime)*100);
                    if (perc <= 100) {
                        updateProgress(perc);
                        setTimeout(animateUpdate, timeoutVal);

                    } else {
                        $(".progressBar").hide();
                    }
                }

            } else {
                $(".progressBar").hide();
            }
        }

        // ------------

        if (item.hudoff == true) {
            $('body').fadeOut(500)
        } else if (item.hudoff == false) {
            $('body').fadeIn(500)
        }


        switch (item.action) {
            case 'update':
            
                $('.velocimetro2').fadeOut(500)

                $("#sede").css("height",100-item.sede + "%" );
				$("#vida").css("height",item.health + "%" );
				$("#fome").css("height",100-item.fome +"%" );
                $("#sede").css("height",100-item.sede +"%" );

                $(".horas").html(item.hour + ":" +item.minute);

                if (item.armour == 0){
                    $("#vidadiv").css("margin-left","53px");
                    $("#coletediv").hide(0);
                } else {
                    $("#vidadiv").css("margin-left","5px");
                    $("#coletediv").fadeIn(500);
                    $("#colete").css("height",item.armour +"%");
                }

                if (item.cupom == true){
                    $(".cupom").css("display","inherit")
                }else{
                    $(".cupom").css("display","none")
                }
                
                if (item.inCar) {
                    $("#background").css("bottom","140px");
                }else {
                    $("#background").css("bottom","100px");
                    $("#background").css("right","-80px");
                }
           
                $("#logo").attr(`src`,item.logo );

                break;
            case 'inCar':

                $("#logo").attr(`src`,item.logo );
        
                $("#sede").css("height",100-item.sede + "%" );
				$("#vida").css("height",item.health + "%" );
				$("#fome").css("height",100-item.fome +"%" );
                $("#sede").css("height",100-item.sede +"%" );

                $(".horas").html(item.hour + ":" +item.minute);
        
                if (item.armour == 0){
                    $("#vidadiv").css("margin-left","53px");
                    $("#coletediv").hide(0);
                } else {
                    $("#vidadiv").css("margin-left","5px");
                    $("#coletediv").fadeIn(500);
                    $("#colete").css("height",item.armour +"%");
                }

                if (item.cupom == true){
                    $(".cupom").css("display","inherit")
                }else{
                    $(".cupom").css("display","none")
                }

                if (item.inCar) {
                    $("#background").css("bottom","140px");
                }else {
                    $("#background").css("bottom","100px");
                }
              
                $('.velocimetro2').fadeIn(500)

                if(item.speed <= 9) {
                    $('#speed').html('00' + item.speed)
                   
                } else if(item.speed <= 44){
                    $('#speed').html('0' + item.speed)
               
                } else if(item.speed <= 64){
                    $('#speed').html('0' + item.speed)
                   
                } else if(item.speed <= 65){
                    $('#speed').html('0' + item.speed)
                 
                } else if(item.speed <= 99){
                    $('#speed').html('0' + item.speed)
                  
    			} else {
                    $('#speed').html(item.speed)
                  
                }
     
                break
            case 'proximity':
                if (item.number == 1) {
                    $('.circle').css('background', 'white')
                    $('.circle2').css('background', 'rgb(156, 155, 155,0.6)')
                    $('.circle3').css('background', 'rgb(156, 155, 155,0.6)')
                } else if (item.number == 2) {
                    $('.circle').css('background', 'white')
                    $('.circle2').css('background', 'white')
                    $('.circle3').css('background', 'rgb(156, 155, 155,0.6)')
                } else if (item.number == 3) {
                    $('.circle').css('background', 'white')
                    $('.circle2').css('background', 'white')
                    $('.circle3').css('background', 'white')
                }
                break;
            case 'talking':
                if (item.falando) {
                    $('.fa-microphone').css('color', 'rgb(16, 158, 214)')

                } else {
                    $('.fa-microphone').css('color', '#fff')
                }
                break;
            case 'connect-radio':
                $('.radio').css('display', 'inherit')
                if (item.freq) {
                    $(".radioText").html(item.freq + "Mhz");
                } else if (item.freq < 1) {
                     $('.radio').css('display', 'none')
                }
                break;
            case 'talking-radio':
                if (item.radio) {
                    $('.fa-microphone').css('color', 'rgb(16, 158, 214)')
                    $('.fa-rss').css('color', 'rgb(16, 158, 214)')
                } else {
                    $('.fa-rss').css('color', '#fff')
                    $('.fa-microphone').css('color', '#fff')
                }
                break;
        }
        if (item.only == "updateSpeed") {
            $('.motor').html(item.gear)
            if(item.speed <= 9) {
                $('#speed').html('00' + item.speed)
               
            } else if(item.speed <= 44){
                $('#speed').html('0' + item.speed)
           
            } else if(item.speed <= 64){
                $('#speed').html('0' + item.speed)
               
            } else if(item.speed <= 65){
                $('#speed').html('0' + item.speed)
             
            } else if(item.speed <= 99){
                $('#speed').html('0' + item.speed)
              
            } else {
                $('#speed').html(item.speed)
              
            }

            $('#fuel').css('width',item.fuel + '%')

           
            let velo = document.querySelector('.velo')


    
    
            let velo_perc = 100 * (item.speed) / (230)
    
            setVeloBar(velo_perc)

        


        if(item.cinto == true) {
            $(".cinto").attr("src", "svgs/cintoon.png");
        } else {
            $(".cinto").attr("src", "svgs/cintooff.png");
        }

        if(item.locked == true) {
            $(".lock").attr("src", "svgs/lockoff.png");
       
        } else {
            
            $(".lock").attr("src", "svgs/lockon.png");
       
        }

        }
    });
})



