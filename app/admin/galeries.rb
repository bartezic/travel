ActiveAdmin.register Gallery do
  menu :priority => 7, :label => proc{ I18n.t('active_admin.menu.galleries') }, :parent => 'Фото'
  
  controller do
    def scoped_collection
      Gallery.includes(:photos).with_translations(I18n.locale)
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :photos_count do |gallery| 
      gallery.photos.size
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
          photo.input(:_destroy, :as => :boolean, :label => "Destroy?") if photo.object
        end
        photo.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.actions
  end
end
