ActiveAdmin.register TourProgram do
  menu :label => proc{ I18n.t('active_admin.menu.tour_programs') }, :parent => 'Тури'

  filter :tour
  filter :day_number
  filter :description

  form do |f|
    f.inputs do
      f.input :tour
      f.input :day_number
      regions(f)
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :description, as: :html_editor
    end
    f.actions
  end
end
