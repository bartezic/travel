ActiveAdmin.register Visa do
  menu :priority => 9, :label => proc{ I18n.t('active_admin.menu.visas') }
  index do
    selectable_column
    id_column
    column :country
    column :visa_type
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :visa_type, as: :radio
      f.input :country
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :description, as: :html_editor
      t.input :foreign_pas, as: :html_editor
      t.input :foreign_pas_duration
      t.input :foreign_pas_additional
      t.input :service_pas
      t.input :diplomatic_pas
    end
    f.buttons
  end
end
