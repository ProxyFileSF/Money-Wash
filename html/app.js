function setDisplay(bool) {
    if(bool) {
        $("body").show();
    } else {
        $("body").hide();
    }
}

/*window.onload = function() {
   setDisplay(false)
}*/

window.addEventListener('message', function(event) {
    var item = event.data
    if(item.type == "ui") {
        setDisplay(item.dStats)
    }
})

document.onkeyup = function(data) {
    if(data.which == 27) {
        $.post('https://ps_washing_station/exit', JSON.stringify({}))
        return
    }
};