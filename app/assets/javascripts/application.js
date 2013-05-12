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
  if(window.chrome) {
    $('.banner li').css({
      'background-size': '100% 100%',
      'min-height': ($(window).width()*1080)/1920+'px'
    });
  }

  var slidey = $('.banner').unslider({
    speed: 500,               //  The speed to animate each slide (in milliseconds)
    delay: 7000,              //  The delay between slide animations (in milliseconds)
    //complete: function() {},  //  A function that gets called after every slide animation
    keys: true,               //  Enable keyboard (left, right) arrow shortcuts
    dots: true,               //  Display dot navigation
    fluid: true              //  Support responsive design. May break non-responsive designs
  });

  if (slidey.length > 0) {
    $(window).resize(function() {
      slidey.data('unslider').next();
      $('.banner li').css('min-height', '');
    });
  }
 
  $('#myCarousel').carousel({
    interval: 5000
  });

  $('#carousel-text').html($('#slide-content-0').html());

  //Handles the carousel thumbnails
  $('[id^=carousel-selector-]').click( function(){
    var id_selector = $(this).attr("id");
    var id = id_selector.substr(id_selector.length -1);
    var id = parseInt(id);
    $('#myCarousel').carousel(id);
  });


  // When the carousel slides, auto update the text
  $('#myCarousel').on('slid', function (e) {
    var id = $('.item.active').data('slide-number');
    $('#carousel-text').html($('#slide-content-'+id).html());
  });

  $('.tour').find('table').addClass('table table-striped table-bordered table-condensed');

  // $('a[data-toggle="tab"]').on('shown', function (e) {
  //   console.log(e.target)
  //   if(e.target.href.split('#')[1] == 'gallery'){
  //     // updateWookmark()
  //     // $('ul.grid li').addClass('loaded')
  //   }
  // })
  //$('ul.grid').photobox('a', { thumbs:true }, function(){});
  $('ul.grid li img').error(function(){
    $(this).closest('li').remove()
  })
});

// function updateWookmark() {
//   $('ul.grid li').wookmark({
//     autoResize: true, // This will auto-update the layout when the browser window is resized.
//     container: $('ul.grid'), // Optional, used for some extra CSS styling
//     offset: 6, // Optional, the distance between grid items
//     flexibleWidth: 200 // Optional, the maximum width of a grid item
//   });
// }

// $('ul.grid').imagesLoaded(function() {
//   updateWookmark()
// });

$('ul.grid li a img').imagesLoaded(function() {
  $.each( $('ul.grid li'), function(index, photo){
    setTimeout( function(){ 
      $(photo).addClass('loaded'); 
    }, 30*index);
  });
  $('ul.grid').photobox('a', { thumbs:true }, function(){});
});