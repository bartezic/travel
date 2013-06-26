ActiveAdmin.register Tag do
  menu :label => proc{ I18n.t('active_admin.menu.tags') }
  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
