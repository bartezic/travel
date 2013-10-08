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
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.uk.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js
//= require jquery.imagesloaded
//= require photobox.min
//= require localization
//= require stroll.min

//////////////////////////////////////////////////
//          METHODS FOR LOCATION HASH           //
//////////////////////////////////////////////////
Hashovka = {
  sep: '&',
  keyValSep: '=',
  getByKey: function(type, key){
    var hash = window.location[type];
    if (hash != ""){ 
      hash = hash.substring(1).split(this.sep); 
      for (var i = hash.length - 1; i >= 0; i--) {
        if((hash[i].indexOf(key) !== -1) && (hash[i].split(this.keyValSep)[0] === key)){
          return hash[i].split(this.keyValSep)[1];
        };
      };
    };
    return false;
  },
  setToKey: function(type, key, value) {
    var hash = window.location[type], arr = [];
    if (hash != ""){ 
      hash = hash.substring(1).split(this.sep); 
      for (var i = hash.length - 1; i >= 0; i--) {
        if((hash[i].indexOf(key) === -1) && (hash[i].split(this.keyValSep)[0] !== key)){
          arr.push(hash[i]);
        };
      };
      arr.push(key+this.keyValSep+value)
      hash = arr.join(this.sep);
    } else {
      hash = key+this.keyValSep+value;
    };
    window.location[type] = hash;
    return value
  }
};

window.app.staticMap = {
  configs: {
    initedContWidth: 0,
    initedMapType: 1
  },
  mapType: function() {
    switch($('.container').width()){
      case 1170:
        return 1;
        break;
      case 940:
        return 2;
        break;
      default:
        return 3;
    }
  },
  initStaticMap: function() {
    var _ = this, 
        type = _.mapType(),
        size;
    
    switch(type){
      case 1:
        size = '570x400';
        break;
      case 2:
        size = '455x429';
        break;
      default:
        size = '364x215&scale=2';
    }
    _.configs.initedMapType = type;

    _.elems.map.html(
      $('<img>',{
        src: 'https://maps.googleapis.com/maps/api/staticmap?center='+ _.elems.map.data('address')
        +'&size='+ size +'&visual_refresh=true&sensor=true&language='+ window.app.locale,
        class: 'map img-responsive'
      })
    );
  },
  initHandlers: function() {
    var _ = this;

    $(window).resize(function() {
      if(_.configs.initedMapType !== _.mapType()){
        _.initStaticMap();
      }
    });
  },
  init: function() {
    this.elems = {
      map: $('#satatic-map')
    };

    if(this.elems.map.length){
      this.initStaticMap();
    }

    this.initHandlers();
  }
};

window.app.panoramio = {
  configs: {
    initedContWidth: 0
  //   original:     'http://static.panoramio.com/photos/original/9363990.jpg',
  //   medium:       'http://mw2.google.com/mw-panoramio/photos/medium/9363990.jpg', //width 500x...
  //   small:        'http://mw2.google.com/mw-panoramio/photos/small/9363990.jpg', //width 240x...
  //   thumbnail:    'http://mw2.google.com/mw-panoramio/photos/thumbnail/9363990.jpg', //width 100x...
  //   square:       'http://mw2.google.com/mw-panoramio/photos/square/9363990.jpg', //width 60x60
  //   mini_square:  'http://mw2.google.com/mw-panoramio/photos/mini_square/9363990.jpg', //width 32x32
  },
  getPhotos: function() {
    $.ajax({
      url: 'http://www.panoramio.com/map/get_panoramas.php',
      dataType: 'JSONP',
      data: {
        set: 'public',
        from: 0,
        to: 20,
        minx: -180,
        miny: -90,
        maxx: 180,
        maxy: 90,
        size: 'medium',
        mapfilter: true,
      }
    }).done(function(res) {
      console.log(res)
    })
  },
  initPanoramioWidgets: function() {
    var _ = this;

    var sand = {
      "rect" : this.elems.panRoot.data()
    };
    var sandRequest = new panoramio.PhotoRequest(sand);
    if($('.container').width() == 1170){
      var attr_ex_photo_options = {
        'width': 500,
        'height': 380,
        'attributionStyle': panoramio.tos.Style.HIDDEN
      };

      var attr_ex_list_options = {
        'width': 70,
        'height': 380,
        'columns': 1,
        'rows': 5,
        'croppedPhotos': true,
        'disableDefaultEvents': [panoramio.events.EventType.PHOTO_CLICKED],
        'orientation': panoramio.PhotoListWidgetOptions.Orientation.VERTICAL,
        'attributionStyle': panoramio.tos.Style.HIDDEN
      };

      var attr_ex_attr_options = {'width': 570};
    } else if ($('.container').width() == 940){
      var attr_ex_photo_options = {
        'width': 455,
        'height': 340,
        'attributionStyle': panoramio.tos.Style.HIDDEN
      };

      var attr_ex_list_options = {
        'width': 455,
        'height': 70,
        'columns': 5,
        'rows': 1,
        'croppedPhotos': true,
        'disableDefaultEvents': [panoramio.events.EventType.PHOTO_CLICKED],
        'orientation': panoramio.PhotoListWidgetOptions.Orientation.HORIZONTAL,
        'attributionStyle': panoramio.tos.Style.HIDDEN
      };

      var attr_ex_attr_options = {'width': 455};
    } else {
      var attr_ex_photo_options = {
        'width': _.elems.panRoot.width(),
        'height': 340,
        'attributionStyle': panoramio.tos.Style.HIDDEN
      };

      var attr_ex_list_options = {
        'width': _.elems.panRoot.width(),
        'height': 70,
        'columns': 5,
        'rows': 1,
        'croppedPhotos': true,
        'disableDefaultEvents': [panoramio.events.EventType.PHOTO_CLICKED],
        'orientation': panoramio.PhotoListWidgetOptions.Orientation.HORIZONTAL,
        'attributionStyle': panoramio.tos.Style.HIDDEN
      };

      var attr_ex_attr_options = {'width': _.elems.panRoot.width()};
    }
    _.configs.initedContWidth = $('.container').width() || _.elems.panRoot.width();
    
    var attr_ex_photo_widget = new panoramio.PhotoWidget(
        'div_attr_ex_photo', sandRequest, attr_ex_photo_options);
   
    var attr_ex_list_widget = new panoramio.PhotoListWidget(
      'div_attr_ex_list', sandRequest, attr_ex_list_options);

    var attr_ex_attr_widget = new panoramio.TermsOfServiceWidget(
      'div_attr_ex_attr', attr_ex_attr_options);

    function onListPhotoClicked(event) {
      var position = event.getPosition();
      if (position !== null) attr_ex_photo_widget.setPosition(position);
    }
    
    panoramio.events.listen(
      attr_ex_list_widget, 
      panoramio.events.EventType.PHOTO_CLICKED,
      function(e) { onListPhotoClicked(e); }
    );
    // attr_ex_photo_widget.enablePreviousArrow(false);
    // attr_ex_photo_widget.enableNextArrow(false);
    attr_ex_photo_widget.setPosition(0);
    attr_ex_list_widget.setPosition(0);
  },
  includePanoramioJS: function() {
    var _ = this;

    $.ajax({
      url: 'http://www.panoramio.com/wapi/wapi.js?v=1&hl=' + window.app.locale,
      dataType: "script",
      success: function(res) {
        _.initPanoramioWidgets();
        $(window).resize();
      }
    });
  },
  initHandlers: function() {
    var _ = this;

    $(window).resize(function() {
      if(($('.container').width() == 0 && _.elems.panRoot.width() !== _.configs.initedContWidth) || _.configs.initedContWidth !== $('.container').width()){
        _.initPanoramioWidgets();
      }
    });
  },
  init: function() {
    this.elems = {
      panRoot: $('#div_attr_ex')
    };

    if(this.elems.panRoot.length){
      this.includePanoramioJS();
    }

    this.initHandlers();
  }
};

$(function() {
  window.app.panoramio.init();
  window.app.staticMap.init();
  
  $('#myCarousel').carousel({
    interval: 5000
  });

  $('.tour table').addClass('table table-striped table-bordered table-condensed');

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
        btn.attr('disabled', false);
      });
    } else {
      alert(window.app.l.v_email_or_phone)
    }
  });

  $('.icon-arrow-right').removeClass('icon-arrow-right').addClass('glyphicon glyphicon-arrow-right');
  $('.icon-arrow-left').removeClass('icon-arrow-left').addClass('glyphicon glyphicon-arrow-left');

  //stroll.bind('.country ul.media-list.stroll');

  $('.locales .locale').click(function(e) {
    if(!$(this).hasClass('active')){
      Hashovka.setToKey('search', 'locale', $(this).data('locale'));
    }
  });

  $('.toggle-popover-stat').popover({
    html: true,
    //title: 'Статистика',
    placement: 'top',
    trigger: 'hover',
    content: $('.popover-stat').removeClass('hidden').remove()
  });

  $('.toggle-countries span').click(function() {
    $(this).addClass('hide');
    $(this).siblings('span').removeClass('hide');
    $('.cont-countries[data-id="' + $(this).closest('small').data('id') + '"]').toggleClass('hide');
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