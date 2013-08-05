ActiveAdmin.register VisaType do
  menu :priority => 9, :label => proc{ I18n.t('active_admin.menu.visa_types') }, :parent => 'Візи'
  index do
    selectable_column
    id_column
    column :title
    translation_status
    default_actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.actions
  end
end
