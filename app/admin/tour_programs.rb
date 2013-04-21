ActiveAdmin.register TourProgram do
  menu :label => proc{ I18n.t('active_admin.menu.tour_programs') } #, :parent => :tour
  # belongs_to :tour
  # navigation_menu :tour
  form do |f|
    f.inputs do
      f.input :tour
      f.input :day_number
      f.input :regions
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :description, as: :html_editor
    end
    f.buttons
  end
end
