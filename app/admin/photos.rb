ActiveAdmin.register Photo do
  menu :priority => 8, :label => proc{ I18n.t('active_admin.menu.photos') }
  index do
    selectable_column
    id_column
    column :title
    # column :galleries
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :asset
      f.input :galleries
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
