//= require active_admin/base


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
});
