class MessageListener {
    eventHandlers = {};
    constructor() {
        window.addEventListener("message", (event) => {
            if (!event || !event.data || !event.data.action) return;

            const func = this.eventHandlers[event.data.action];
            if (func) func(event.data);
        });
    }
    addHandler(actionName, func) {
        this.eventHandlers[actionName] = async function (data) {
            func(data);
        };
    }
}

const messageListener = new MessageListener();

// Create our number formatter.
const formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
});

let myID = true;
messageListener.addHandler("show", (data) => {
    myID = data['myID'];
    getPlayerInfos();
    $("#action-menu").fadeIn(400);
    $("#action-menu").css({ "display": "flex" });
});

messageListener.addHandler("updatePhoto", (data) => {
    $("#action-menu").fadeIn(400);
    $("#action-menu").css({ "display": "flex" });
});

messageListener.addHandler("hide", (data) => {
    $("#action-menu").css({ "display": "none" });
});

let mainDisplay = false;
let inProgress = false;
$(document).on("click", "#flipID", function () {
    if (inProgress) return
    inProgress = true;
    $(".right-side").fadeOut(300);
    setTimeout(function () {
        if (mainDisplay) {
            $(`.right-side`).css({
                'flex-direction': 'row',
                'width': '100%',
                'padding': '0px 0px',
                'padding-top': '0px',
                'margin-top': '8px',
            });
            if (myID) {
                $(`.right-side`).html(`
                <div class="allInfos">
                    <div class="item username-wallet"><p>${mainOptions.option1}</p>  <b>WALLET_VALUE</b></div>
                    <div class="item username-bank"><p>${mainOptions.option2}</p>  <b>BANK_VALUE</b></div>
                    <div class="item username-coins"><p>${mainOptions.option7}</p>  <b>USER_COINS</b></div>
                </div>
        
                <div class="allInfos2">
                    <div class="item username-bills"><p>${mainOptions.option3}</p>  <b>BILLS_VALUE</b></div>
                    <div class="item username-age"><p>${mainOptions.option5}</p>  <b>USER_AGE</b></div>
                    <div class="item username-job"><p>${mainOptions.option6}</p>  <b>USER_JOBS</b></div>
                </div> 
            `);
            } else {
                $(`.right-side`).html(`
                <div class="allInfos">
                    <div class="item username-bills"><p>${mainOptions.option3}</p>  <b>BILLS_VALUE</b></div>
                    <div class="item username-status"><p>${mainOptions.option5}</p>  <b>RELATIONSHIP</b></div>
                </div>
        
                <div class="allInfos2"></div> 
            `);
            }
    
            displayMoreInfos();
            $("#baseIcon").fadeOut(300);
        } else {
            $(`.right-side`).css({
                'flex-direction': 'column',
                'width': '50%',
                'padding': '0px 20px',
                'padding-top': '10px',
                'margin-top': '15px',
            });
            $(`.right-side`).html(`
                <div class="name item username-name"><b>USERNAME</b></div>
                <div class="item username-phone"><p>TELEFONE</p>  <b>USER_PHONE</b></div>
                <div class="item username-user_id"><p>PASSAPORTE</p>  <b>USER_ID</b></div>
                <div class="item username-vip"><p>VIP</p><b>VIP</b></div>
            `);
            getPlayerInfos();
            $("#baseIcon").fadeIn(300);
        }
    }, 300)
    setColors(typeID);
    $(".right-side").fadeIn(300);
    mainDisplay = !mainDisplay
    $(`.body-main`).addClass('rotate');
    setTimeout(function () {
        $(`.body-main`).removeClass('rotate');
        inProgress = false;
    }, 500)
});

let signEdit = false;
$(document).on("click", "#signEdit", function () {
    signEdit = true;
    $.post("http://vrp_identity/requireSign", JSON.stringify({}), (data) => {
        if(data) displaySign();
    });
});

$(document).on("click", ".submit", function () {
    signEdit = true;
    $('.mainArea').html(`<div class="loader"></div>`);
    $.post("http://vrp_identity/saveSign", JSON.stringify({
        index: auxAssing
    }), (data) => {
        getPlayerInfos();
    });
});

$(document).on("click", ".md-image", function () {
     $('.mainArea').html(`<div class="loader"></div>`);
     $.post("http://vrp_identity/closeNui");
     $.post("http://vrp_identity/takePhoto");
});

$(document).ready(function () {
    document.onkeyup = function (data) {
        if (data.which == 27) {
            if (signEdit) {
                signEdit = false;
                getPlayerInfos();
                $.post("http://vrp_identity/cancelSign");
            } else
                $.post("http://vrp_identity/closeNui");
        }
    }
});

let mainData = [];
let moreData = [];
let typeID = false;
const getPlayerInfos = () => {
    $.post("http://vrp_identity/getPlayerInfos", JSON.stringify({}), (data) => {

        let { resp, type } = data;
        typeID = type;
        mainData = [], moreData = [];
        for (let i = 0; i < resp.length; i++)
            if (i <= 5) mainData.push(resp[i])
            else moreData.push(resp[i])
    
        if (myID) displaySides(type['icon']);
        else displayOtherSides(type['icon']);

        setColors(type);
        $('.surname').text(mainData[0]);
        $('.username-name b').text(mainData[1]);
        $('.username-user_id b').text(mainData[3]);
        $('.username-phone b').text(mainData[4]);
        $('.user-image img').attr("src", mainData[5]);

        if (moreData[8] >= 0) {
            $('.username-vip b').text(moreData[7]+" - "+moreData[8]+' dias');
        }else {
            $('.username-vip b').text(moreData[7]);
        }
    });
}

let auxAssing = ''
const displaySign = () => {
    $('.mainArea').html(`
        <div class="search">
            <div style="display: flex;align-items: center;">
            <input class="search-input" maxlength="18" data-type="assing" spellcheck="false" value="" placeholder="Insira sua Assintura">
            <span class="material-icons-outlined" style="color: rgba(255, 255, 255, 0.2); font-size: 16px; margin-top: 8px;">create</span>
            </div>
            <p class="submit">Assinar</p>
        </div> 
    `);
    $("input[data-type='assing']").on({
        keyup: function () {
            auxAssing = $(this).val()
        },
    });
}

//  <span class="material-icons-outlined md-image">add_photo_alternate</span>
const displaySides = (index) => {
    $('.mainArea').html(`
        <div class="left-side">
            <div class="user-image">
            <img src="https://cdn.discordapp.com/attachments/830569806683439115/916186036537810995/screenshot.png"/>
            </div>
            <p class="surname">Vulgo Careca</p>
            <span id="signEdit" class="material-icons-outlined md-edit">edit</span>
            <span class="material-icons-outlined md-image">add_photo_alternate</span>
        </div>
        <div class="right-side">
            <div class="item username-phone"><p>TELEFONE</p>  <b>USER_PHONE</b></div>
            <div class="item username-user_id"><p>PASSAPORTE</p>  <b>USER_ID</b></div>
            <div class="item username-vip"><p>VIP</p><b>VIP</b></div>
        </div>
        <div id="baseIcon" class="final-side"><span class="material-icons-outlined md-type">${index}</span></div>
        <span id="flipID" class="material-icons-outlined md-flip">read_more</span>
    `);
}

const displayOtherSides = (index) => {
    $('.mainArea').html(`
        <div class="left-side">
            <div class="user-image">
            <img src="https://cdn.discordapp.com/attachments/830569806683439115/916186036537810995/screenshot.png"/>
            </div>
            <p class="surname">Vulgo Careca</p>
        </div>
        <div class="right-side">
            <div class="item username-phone"><p>TELEFONE</p>  <b>USER_PHONE</b></div>
            <div class="item username-user_id"><p>PASSAPORTE</p>  <b>USER_ID</b></div>
            <div class="item username-vip"><p>VIP</p><b>VIP</b></div>
        </div>
        <div id="baseIcon" class="final-side"><span class="material-icons-outlined md-type">${index}</span></div>
        <span id="flipID" class="material-icons-outlined md-flip">read_more</span>
    `);
}

const displayMoreInfos = () => {
    $('.username-wallet b').text(formatter.format(moreData[0]).replaceAll(".","@").replaceAll(",",".").replaceAll("@",","));
    $('.username-bank b').text(formatter.format(moreData[1]).replaceAll(".","@").replaceAll(",",".").replaceAll("@",","));
    $('.username-bills b').text(formatter.format(moreData[2]).replaceAll(".","@").replaceAll(",",".").replaceAll("@",","));
    $('.username-job b').text(moreData[3]);
    $('.username-status b').text(moreData[4]);
    $('.username-age b').text(moreData[5]);
    $('.username-coins b').text(moreData[6]);
}

const setColors = (data) => {
    $(".body-main").css({ "background-image": `linear-gradient(to top right, ${backgroundIntColor} 50%, ${data['gradientColor']})` });
    // $(".item b").css({ "color": `${data['mainColor']}` });
    $(".material-icons-outlined.md-code").css({ "color": `${data['mainColor']}` });
    $(".material-icons-outlined.md-type").css({ "color": `${data['mainColor']}` });
}