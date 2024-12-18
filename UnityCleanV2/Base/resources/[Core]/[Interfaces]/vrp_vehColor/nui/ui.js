// cor primaria
var colorPickerP = new iro.ColorPicker("#colorPicker", {
    width: 140,
    color: "rgb(255, 255, 255)",
    borderWidth: 1,
    borderColor: "#000",
    padding: 0
});

colorPickerP.on(["color:change"], function (color) {
    $.post('http://vrp_vehColor/changeItem',JSON.stringify({type: 'color', r: color.rgb.r, g: color.rgb.g, b: color.rgb.b}) )
});
// cor secundaria
var colorPickerS = new iro.ColorPicker("#ScolorPicker", {
    width: 140,
    color: "rgb(255,255,255)",
    borderWidth: 1,
    borderColor: "#000",
    padding: 0
});


colorPickerS.on([ "color:change"], function (color) {
    $.post('http://vrp_vehColor/changeItem',JSON.stringify({type: 'Scolor', r: color.rgb.r, g: color.rgb.g, b: color.rgb.b}) )
});
// cor smoke
var colorPickerSmoke = new iro.ColorPicker("#smokePicker", {
    width: 140,
    color: "rgb(255,255,255)",
    borderWidth: 1,
    borderColor: "#000",
    padding: 0
});

colorPickerSmoke.on([ "color:change"], function (color) {
    $.post('http://vrp_vehColor/changeItem',JSON.stringify({type: 'smoke', r: color.rgb.r, g: color.rgb.g, b: color.rgb.b}) )
});

$(document).ready(function(e){
    window.addEventListener('message', mec.eventHandler)
})
var submenu;
const mec = {
    primaryTemplate: (name,icon,label, haveItem) => {
         return `<div class="customItem sectionItem append ${name}" href="${name}" onclick="selectHome(this)" data-haveItem="true">
                    <div class="line"></div>
                    <div class="lineBottom"></div>
                    <div class="imgItem">
                        <img src="assets/${icon}">
                    </div>
                    <div class="label">${label}</div>
                    <div class="overlayOpacity"></div>
                </div>`
    },  
    secondaryTemplate: (name, icon, parts, type, index, installed) => {
        let content = `<div class="menu-option append" id="${name}">
                    <div class="customContainer">`     
                    var i
                    let itemname
                    for (i = -1; i < parts; i++) {
                        if (type == 'toggle') {
                            if (i == -1){ itemname = 'Nenhum' }else {itemname = "Instalado"}
                        } else {
                            if (i == -1){ itemname = 'Padrão' }else {itemname = i}
                        }
                        if ( type != "window" || i != -1 ) {
                            content = content + `
                            <div class="customItem ${i}" onclick="selectItem(this)" data-custom="${i}" data-part="${index}" data-type="${type}" data-beforeInstalled="${installed}" >
                                <div class="line"></div>
                                <div class="lineBottom"></div>
                                <div class="haveItem" style="display:none">
                                    <p>Instalado</p>
                                </div>
                            
                                <div class="imgItem">
                                    <img src="assets/${icon}">
                                </div>
                                <div class='partName'>${itemname}</div>
                                <div class="overlayOpacity"></div>
                            </div>`
                        }
                    }
                    content = content+ `</div>
                </div>`
                return content 
    },      
    eventHandler: (event) => {
        let action = event.data.action
        const events = mec.acceptedEvents[action]
        if(events){
            events(event)
        }
    },
    open: (event) => {
        $('.append').remove()
        event.mods.forEach(element => {
            $('.customContainer').append( mec.primaryTemplate( element.part, element.img, element.label, element.haveItem ) )
            $( mec.secondaryTemplate( element.part, element.img, element.availableMods, element.type, element.index, element.installed ) ).insertAfter( "#Cores" )         
            
            $('#'+element.part+' .'+element.installed+' .haveItem').show()
            
            if ( element.haveItem == false ) { 
                $('.'+element.part+' .label').css('color', 'red');
                $('.'+element.part).css('opacity', '0.8');
                $('.'+element.part).attr('data-haveItem', false);
            }
        })

        $('body').show()
        $('.menu-option').hide()
        $('#home').slideDown(1000)
        $('#textContent').text('Mecânica')
        $('#textPrice').html('<div style="font-size: 10px;position: absolute;top: -16px; "></div><span id="prefix">$</span>'+00+',<span id="zeroCount">00</span>');
        $('#textmoney').html('<span id="prefix">R$</span>'+formatarNumero(event.playerMoney)+',<span id="zeroCountfchangeColorName">00</span>');
    },
    close: () => {
        $('body').hide();
        $.post('http://vrp_vehColor/close')
    },
    acceptedEvents: {
        open(event) {
           mec.open(event.data) 
        },
        changeColorName(event){
            $('#'+event.data.type+'Colorname').html(event.data.cName)
        },
        changeXenonColorName(event){
            $('#farolColorname').html(event.data.cName)
        },
        update(event){
            let data = event.data
            let partType = data.partType
            if (partType == 'wheel'){
                $('#'+data.partname+' .'+data.installedPart+' .haveItem').show()
                $('#'+data.oldWheelType+' .'+data.oldInstalled+' .haveItem').hide()
            } else {
                $('#'+data.partname+' .'+data.installedPart+' .haveItem').show()
                $('#'+data.partname+' .'+data.oldInstalled+' .haveItem').hide()
            }
            $('#textPrice').html('<div style="font-size: 10px;position: absolute;top: -16px;"></div><span id="prefix">R$</span><span id="valMods">'+formatarNumero(data.totalPrice)+'</span>,<span id="zeroCount">00</span>');
            $('#textmoney').html('<span id="prefix">R$</span>'+formatarNumero(data.playerMoney)+',<span id="zeroCount">00</span>');
        },
        updateColors(event){
            data = event.data
            colorPickerP.color.rgb = { r: data.primary.r, g: data.primary.g, b: data.primary.b };
            colorPickerS.color.rgb = { r: data.secondary.r, g: data.secondary.g, b: data.secondary.b };
            colorPickerSmoke.color.rgb = { r: data.smoke.r, g: data.smoke.g, b: data.smoke.b };          
        }
    }                
}

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

document.onkeyup = function(data) {
    if (data.which == 27) {
        if(submenu) {
            requestModAccept()
        }
    }
    if ( data.which == 27) {
        if(!submenu) {
            mec.close()
        }
    }
}

function requestModAccept() {
    $("#warning").show();
}

function acceptMod() {
    $("#warning").hide();
    $.post('http://vrp_vehColor/changeCamera',JSON.stringify({ type: 'reset' }) )
    $('.menu-option').hide();
    $('#home').fadeIn();
    $('.sectionItem').show();
    $('#textContent').text('Mecânica');
    $('.container').css('height', '160px');
    let strPrice = $('#valMods').text();
    let price = strPrice.replace(".", "");
    submenu = false;
    $.post('http://vrp_vehColor/acceptMod',JSON.stringify({price: price}));
}

function declinetMod() {
    $("#warning").hide();
    $.post('http://vrp_vehColor/changeCamera',JSON.stringify({ type: 'reset' }) )
    $('.menu-option').hide();
    $('#home').fadeIn();
    $('.sectionItem').show();
    $('#textContent').text('Mecânica');
    $('.container').css('height', '160px');
    submenu = false;
    $.post('http://vrp_vehColor/declineMod' )
}

function selectHome(e) {   
    var haveItem = $(e).attr("data-haveItem")
    if (haveItem == 'true') {
        var id = $(e).attr("href")
        $.post('http://vrp_vehColor/changeCamera', JSON.stringify({ type: id }) )

        $('.sectionItem').hide()
        $("#home").hide()
        $("#home").fadeOut()
        $('.sectionItem').find('span').css('border-bottom', '0')
        $('.container').css('height', '500px');
        
        $("#" + id).show()
        $("#" + id).fadeIn()
        $('#textContent').text(id)
        $(e).find('span').css('border-bottom', '5px solid #ba6512')
        submenu = true;
    }
}

function selectItem(element) {

    $('.customItem').find('.linesCustom').remove();
    $('.customItem').css('border', '0');
    $(element).css('border', '2px solid #fff');
    // $(element).css('border-left', '2px solid #fff');
    $(element).append(`
    <div class="linesCustom">
        <div class="line-left"></div>
        <div class="line-right"></div>
        <div class="line-bottoml"></div>
        <div class="line-bottomr"></div>
    </div>
    `);
    var beforeInstalled = $(element).attr("data-beforeInstalled")
    $.post('http://vrp_vehColor/changeItem',JSON.stringify({ type: element.dataset.type, value: element.dataset.value, part: element.dataset.part, partId: element.dataset.custom, before: beforeInstalled }) )
    submenu = true;
}

function selectColor(type, op, colorP){
    $.post('http://vrp_vehColor/changeItem',JSON.stringify({ type: 'customcolor', customColor: type, op: op, colorP: colorP }) )
}

function setXenonLights(op){
    $.post('http://vrp_vehColor/changeItem',JSON.stringify({ type: 'xenoncolor', op: op}) )
}

