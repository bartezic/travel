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
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.uk.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js
//= require jquery.imagesloaded
//= require photobox.min
//= require localization
  
$(function() {

  $('#myCarousel').carousel({
    interval: 5000
  });

  $('.tour').find('table').not('#vkshare0').addClass('table table-striped table-bordered table-condensed');

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
  };

  $('.datepicker').datepicker({
    format: 'dd-mm-yyyy',
    startDate: new Date(),
    autoclose: true,
    language: window.app.locale,
  }).on('changeDate', function(e) {
    $('#request_action_departure_date').val(e.date.toString())
  });

  $('.request-action-submit').click(function(e) {
    var btn = $(this),
        modal = $('#myModal'),
        modal2 = $('#myModal2'),
        form = modal.find('form'),
        success = modal2.find('.request-action-success'),
        failure = modal2.find('.request-action-failure');

    if($('#request_action_email').val() || $('#request_action_phone').val()){
      btn.attr('disabled', true);
      
      $.ajax({
        type: 'POST',
        url: '/request_actions',
        data: form.serialize(),
        dataType: 'json'
      }).done(function(res) {
        form.each(function(){ this.reset() });
        modal.modal('hide');
        modal2.modal('show');
        if(res.success){
          failure.addClass('hidden');
          success.removeClass('hidden');
        } else {
          success.addClass('hidden');
          failure.removeClass('hidden');
        }
      });
    } else {
      alert(window.app.l.v_email_or_phone)
    }
  });
});

$('ul.grid li a img').imagesLoaded(function() {
  $.each( $('ul.grid li'), function(index, photo){
    setTimeout( function(){ 
      $(photo).addClass('loaded'); 
    }, 30*index);
  });
  if($('ul.grid').length){
    $('ul.grid').photobox('a', { thumbs:true }, function(){});
  }
});

//window.open('https://www.facebook.com/dialog/oauth?client_id=256487544493099&display=popup&redirect_uri=http://mongrasse.com.ua/home','fb','resizable=yes,scrollbars=yes,width=500,height=500,left=200,top=200')