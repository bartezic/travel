ActiveAdmin.register Day do
  menu :label => proc{ I18n.t('active_admin.menu.days') }, :parent => 'Тури'
  form do |f|
    f.inputs do
      f.input :day_of_life
    end
    f.actions
  end
end
