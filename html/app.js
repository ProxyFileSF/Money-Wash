function setDisplay(bool) {
    if(bool) {
        $("body").show();
    } else {
        $("body").hide();
    }
}

window.onload = function() {
    setDisplay(false)
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
});

$(document).on('click', '#ps_wm_submit', function(){
    $.post('https://ps_money_wash/submit', JSON.stringify({
        amount: $("#ps_wm_input_bx").val(),
    }))
    return
});

$(document).on('click', '#ps_wm_close', function(){
    $('#ps_wm_background').addClass("animate__animated animate__fadeOut")
    setTimeout(function() {
        $.post('https://ps_money_wash/exit', JSON.stringify({}))
    }, 750)
    return
});

document.onkeyup = function(data) {
    if(data.which == 27) {
        $.post('https://ps_money_wash/exit', JSON.stringify({}))
        return
    }
};