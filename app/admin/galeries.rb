ActiveAdmin.register Gallery do
  menu :priority => 7, :label => proc{ I18n.t('active_admin.menu.galleries') }
  index do
    selectable_column
    id_column
    column :title
    column :photos_count do |gallery| 
      gallery.photos.count
    end
    translation_status
    default_actions
  end

  form do |f|
    f.inputs "photos" do
      f.has_many :photos do |photo|
        photo.inputs do
          photo.input :asset
          photo.input :asset_remote_url
          # photo.inputs 'Photo' do
          #   image_tag asset(:thumb_150x), :id => "photoAsset"
          # end
        end
        photo.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
