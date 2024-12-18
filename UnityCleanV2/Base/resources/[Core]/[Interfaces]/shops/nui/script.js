window.addEventListener("message",(event)=>{
    switch (event.data.action) {
        case "open":
            menuManager.reset()
            $('.shops-name hehe').text(event.data.shopName)
            let productData = event.data.shop
            for (const x in productData.products) {
                $('.shops-category').append(`
                    <div class="shops-single-category" onclick="selectCategory(this)" data-category="${x}">
                        <img src="${productData.products[x].icon}"/>
                    </div>
                `)
              
                for (const z in productData.products[x].itens) {
                    $(".shops-body").append(`
                    <div class="shops-single-product" style="display: none;" data-category="${x}">
                        <div class="shop-inner-product">
                            <div class="shop-inner-product-image">
                                <img src="${(productData.products[x].itens[z].image) ? productData.products[x].itens[z].image : `${event.data.imagesIP}${z}.png` }" alt="" srcset="">
                            </div>
                            <div class="shop-inner-product-name">
                               ${productData.products[x].itens[z].name}
                            </div>
                            <div class="shop-inner-product-price">
                                <span>
                                    R$ ${productData.products[x].itens[z].price}
                                </span>
                            </div>
                            <div class="shop-inner-product-price-buy" data-product="${z}" onclick="buyProduct(this)">
                                COMPRAR
                            </div>
                        </div>
                    </div>
                    `)
                }
                if(productData.products[x].default){
                    selectCategoryRaw(x)
                }
            }
           
            $(".shops-interface").fadeIn(1500);
            
            break;
    }
})

function selectCategoryRaw(category){
    if(!$(`.shops-single-category[data-category="${category}"]`).hasClass("active")){
        $(".shops-single-category").removeClass("active")
        $(`.shops-single-category[data-category="${category}"]`).addClass("active")
        $('.shops-body .shops-single-product').hide()
        $(`.shops-body .shops-single-product[data-category="${category}"]`).show("slow")
    }
}

function selectCategory(element){
    if(!$(element).hasClass("active")){
        $(".shops-single-category").removeClass("active")
        $(element).addClass("active")
        $('.shops-body .shops-single-product').hide()
        $(`.shops-body .shops-single-product[data-category="${$(element).data('category')}"]`).show("slow")
    }
}

function buyProduct(element){
    let product = $(element).data('product')
    $.post("https://shops/buyProduct", JSON.stringify({ product }));
}

$(document).keyup(function(e) {
    if (e.keyCode == 27) {
        $(".shops-interface").fadeOut(500);
        $.post("https://shops/close_shop");
    }
})

const menuManager = {
    reset: function () {
        $('.shops-category').html("");
        $('.shops-body').html("");
    }
}