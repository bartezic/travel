// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require_tree .

$(function() {
 
  $('#myCarousel').carousel({
    interval: 5000
  });

  $('.tour').find('table').addClass('table table-striped table-bordered table-condensed');

  $('ul.grid li img').error(function(){
    $(this).closest('li').remove()
  });
  
  // Filters
  $('.filters .checkbox input[type=checkbox]').change(function(){
    searchAndFilter();
  });

  $('button.btn.search').click(function(e) {
    searchAndFilter();
  });

  function searchAndFilter () {
    var query = '?' + $('form.filters').serialize();
    if ($('.search-query').val().length > 0 ){
      query += '&query=' + $('.search-query').val();
    }
    window.location.search = query;
  }
});

$('ul.grid li a img').imagesLoaded(function() {
  $.each( $('ul.grid li'), function(index, photo){
    setTimeout( function(){ 
      $(photo).addClass('loaded'); 
    }, 30*index);
  });
  $('ul.grid').photobox('a', { thumbs:true }, function(){});
});