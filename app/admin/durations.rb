ActiveAdmin.register Duration do
  menu :label => proc{ I18n.t('active_admin.menu.durations') }, :parent => 'Тури'
  form do |f|
    f.inputs do
      f.input :count_of_night
    end
    f.actions
  end
end
