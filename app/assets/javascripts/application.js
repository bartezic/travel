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
});