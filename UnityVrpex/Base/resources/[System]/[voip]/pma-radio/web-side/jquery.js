$(document).ready(function(){
    $('#freq').focus(function() {
        $(this).val('');
    });
  
    window.addEventListener("message",function(event){
        switch (event.data.action){
            case "showMenu":
                $("#actionmenu").fadeIn(500);
                break;
        }
    });  

    document.onkeyup = function(data){
        const key = data.key;
        switch(key) {
            case 'Escape':
                $("#actionmenu").fadeOut(500);
                $.post("http://pma-radio/invClose", JSON.stringify({}));
                break;
            case 'Enter':
                document.getElementById("freq").blur();
                setFrequency();
                break;
        }
	}
});

$(document).on("click", ".ativar", debounce(function(){
	setFrequency();
}));

$(document).on("click", ".desativar", debounce(function(){
	$.post("http://pma-radio/inativeFrequency");
}));

function debounce(func,immediate){
	var timeout
	return function () {
		var context = this, args = arguments
		var later = function(){
			timeout = null
			if (!immediate) func.apply(context,args)
		}
		var callNow = immediate && !timeout
		clearTimeout(timeout)
		timeout = setTimeout(later,250)
		if (callNow) func.apply(context,args)
	}
}

const setFrequency = debounce(() => {
    let freq = parseInt($('#freq').val());
	if (freq > 0){
		$.post("http://pma-radio/activeFrequency",JSON.stringify({ freq }));
	}
});