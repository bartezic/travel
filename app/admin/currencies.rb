ActiveAdmin.register Currency do
  menu :label => proc{ I18n.t('active_admin.menu.currencies') }, :parent => 'Тури'
  form do |f|
    f.inputs do
      f.input :code
      f.input :symbol
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.actions
  end
end
