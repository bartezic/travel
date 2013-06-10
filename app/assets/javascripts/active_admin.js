//= require active_admin/base
//= require select2/select2.min.js
//= require select2/select2_locale_ua.js



$(function() {
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
  }

  $('#tour_photo_id, #country_photo_id').select2({
    formatResult: format,
    formatSelection: format,
    escapeMarkup: function(m) { return m; }
  });

  //$('#country_continent_ids').select2();

  $('.select2-container').width($('.select2-container').outerWidth()+50);
});
