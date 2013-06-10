ActiveAdmin.register Attraction do
  menu :priority => 6, :label => proc{ I18n.t('active_admin.menu.attractions') }
  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag a.gallery.photos.first.asset(:thumb_150x) }
    end
    column :region
    column :gallery
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :gallery
      f.input :region
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
