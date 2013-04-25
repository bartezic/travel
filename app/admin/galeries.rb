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
    f.inputs do
      f.input :photos, as: :check_boxes
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
