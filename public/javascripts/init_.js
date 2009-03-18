$(document).ready(function(){
  
  // search button value
  $("#search .button").click(function() {
    if($(this).val() == 'Fulltext search') $(this).val('');
    $(this).parents("#search").find(".phrases").removeClass('hidden');
    return false;
  });
  
  // members filter
  $(".boxFilter .h a").click(function() {
    var obj = $(this).parents(".boxFilter").find(".in");
    if($(obj).hasClass("filterClose")) {
      $(obj).removeClass("filterClose");
      $(this).text('Close filter');
    } else {
      $(obj).addClass("filterClose");
      $(this).text('Open filter');
    }
    
    $(obj).slideToggle('slow');
    return false;
  });
  
  // add item na hover
  $(".main").hover(
    function() {
      $(this).find("a.new").show();
    }, 
    function() {
      $(this).find("a.new").hide();
    }
  );
  
  // skryvani potvrzovacih hlasek
  $(".notice").wait(3000).fadeOut();
  $(".message").wait(3000).fadeOut();
  
  // calendar tooltip
  $(".tooltip").cluetip({
    splitTitle: '|',
    width: '150px',
    showTitle: false,
    tracking: true,
    dropShadow: false,
    cluetipClass: 'techlab',
    topOffset: 20,
    leftOffset: -75,
    positionBy: 'mouse',
    dropShadow: false,
    fx: {
      open: 'fadeIn',
      openSpeed: ''
    }
  });
});

window.onload = init;
function init() {
	document.onclick = hideElements;
}

function hideElements(e) {
	if (document.all) e = event;
	if (e.target) source = e.target;
	else if (e.srcElement) source = e.srcElement;
	if (source.nodeType == 3) source = source.parentNode;
	
	if (source.tagName.toLowerCase() != 'input') {
    $("#search .phrases").addClass("hidden");
  }
  
  //return false;
}
