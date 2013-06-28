//= require active_admin/base
//= require select2/select2.min.js
//= require select2/select2_locale_ua.js

window.adminApp = (window.adminApp  || {});
window.adminApp.trasl = {

  configs: {
    url: 'https://translate.yandex.net/api/v1.5/tr.json/translate',
    apiKey: 'trnsl.1.1.20130628T094430Z.e271ab766a48ca42.a64b41ec92ce0dbec000a18165f1a02d3d28374e'
  },

  traslPackage: {
    fromId: '',
    toId: '',
    fromText: '',
    toText: '',
    format: 'plain',
    locale: 'ru-uk'
  },

  pasteTranslatedText: function() {
    var _ = this;

    if(_.traslPackage.format === 'html'){
      $('#'+ _.traslPackage.toId).closest('.html_editor').data('editor')._editor.setValue(_.traslPackage.toText);
    } else {
      $('#'+ _.traslPackage.toId).val(_.traslPackage.toText);
    }
  },

  transleting: function() {
    var _ = this;

    $.ajax({
      type: 'POST',
      url: _.configs.url,
      data: { 
        key: _.configs.apiKey,
        lang: _.traslPackage.locale,
        text: _.traslPackage.fromText,
        format: _.traslPackage.format
      }
    }).done(function(res) {
      _.traslPackage.toText = res.text[0];
      _.pasteTranslatedText();
    });

  },

  formingTranslPachage: function(el, format) {
    var _ = this;

    _.traslPackage.format = format;
    _.traslPackage.fromText = el.val();
    _.traslPackage.locale = el.closest('fieldset').hasClass('locale-ru') ? 'ru-uk' : 'uk-ru';
    _.traslPackage.fromId = el.attr('id');

    if(_.traslPackage.fromId.indexOf('_0_') >= 0){
      _.traslPackage.toId = _.traslPackage.fromId.replace('_0_','_1_');
    } else {
      _.traslPackage.toId = _.traslPackage.fromId.replace('_1_','_0_');
    };

    if($('#'+_.traslPackage.toId).val().length === 0){
      _.transleting();
    };
  },

  bindEditorEvents: function() {
    var _ = this;

    $.each(_.elems.htmlEditors(), function(i, el) {
      if( $(el).data("editor") !== undefined ){
        $(el).data("editor")._editor.on('change', function() {
          _.formingTranslPachage($(el).find('textarea'), 'html');
        });
      };
    });
  },

  initHandlers: function() {
    var _ = this; 

    _.elems.form.on('change', 'fieldset.locale input, fieldset.locale textarea', function() {
      _.formingTranslPachage($(this), 'plain');
    });

    _.elems.form.on('click', '.has_many .button', function() {
      _.elems.htmlEditors().filter(function() { 
        return $(this).data("editor") === undefined 
      }).editor(window.AA.editor_config);

      _.bindEditorEvents();
    });

    _.bindEditorEvents();
    
    $(window).load(function() {
      _.bindEditorEvents();
    });
  },

  init: function() {
    this.elems = {
      form: $('#active_admin_content form'),
      htmlEditors: function() {
        return $('.html_editor');
      }
    };

    this.initHandlers();
  }
};

$(function() {
  window.adminApp.trasl.init();

  var photoFile = $('#photo_asset');
  photoFile.change(function() {
    var reader;
    if (this.files && this.files[0]) {
      reader = new FileReader();
      reader.onload = function(e) {
        $('#photoAsset').attr("src", e.target.result).width(150);
        return $('#photo_asset_remote_url').val("");
      };
      return reader.readAsDataURL(this.files[0]);
    }
  });
  $('#photo_asset_remote_url').change(function() {
    $('#photoAsset').attr("src", $(this).val()).width(150);
    photoFile.replaceWith( photoFile = photoFile.val('').clone( true ) )
  });

  // $('#photoAsset').error(function() {
  //   $('#photo_asset_remote_url').val("");
  // });

  function format(state) {
    var option = state.element;
    if (!state.id) return state.text; // optgroup
    return "<img class='select-photo-thumb' src='" + $(option).data('thumb') + "'/>" + state.text;
  };

  $('#tour_photo_id, #country_photo_id').select2({
    formatResult: format,
    formatSelection: format,
    escapeMarkup: function(m) { return m; }
  });

  $("#tour_tag_ids, #continent_tag_ids, #country_tag_ids, #region_tag_ids, #hotel_tag_ids, #attraction_tag_ids").select2();

  $('.has_many.tags li.input').remove();

  //$('#country_continent_ids').select2();
  var select2Width = $('.select2-container').outerWidth()+50;
  $('.select2-container').width(500);
  $('#tour_photo_input .select2-container, #country_photo_input .select2-container').width(select2Width);
});
