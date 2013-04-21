ActiveAdmin.register Currency do
  menu :label => proc{ I18n.t('active_admin.menu.currencies') }
  form do |f|
    f.inputs do
      f.input :code
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
