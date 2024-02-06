var vat = 0;

function setDisplay(bool) {
    if(bool) {
        $("body").show();
    } else {
        $("body").hide();
    }
}

/* Enable / Disable UI from IG */
window.addEventListener('message', function(event) {
    var item = event.data
    if(item.type == "ui") {
        if(item.dStats) {
            $('#ps_wm_background').removeClass("animate__fadeOut")
        }
        setDisplay(item.dStats)
    }

    if(item.type == "location") {
        $("#ps_wm_location").text("Located at: " + item.location)
    }

    if(item.type == "vatWash") {
        vat = item.vatWash;
    }
});

$(document).on('click', '#ps_wm_submit', function(){
    $.post('https://ps_money_wash/submit', JSON.stringify({
        amount: $("#ps_wm_input_bx").val(),
    }))
    return;
});

$(document).on('click', '#ps_wm_close', function(){
    $('#ps_wm_background').addClass("animate__animated animate__fadeOut")
    setTimeout(function() {
        $.post('https://ps_money_wash/exit', JSON.stringify({}))
    }, 750)
    return;
});

$(document).on('input', '#ps_wm_input_bx', function() {
    if($('#ps_wm_input_bx').val() != "") {
        var prec = 1.0 - vat
        var BlckVal = Number($('#ps_wm_input_bx').val()) * prec
        var CashVal = $('#ps_wm_input_bx').val()

        $('#ps_wm_cash').text(BlckVal+"€")
        $('#ps_wm_blck').text(CashVal+"€")
    } else {
        $('#ps_wm_cash').text('0€')
        $('#ps_wm_blck').text('0€')
    }
});

document.onkeyup = function(data) {
    if(data.which == 27) {
        $.post('https://ps_money_wash/exit', JSON.stringify({}))
        return;
    }
};