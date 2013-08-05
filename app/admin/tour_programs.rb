ActiveAdmin.register TourProgram do
  menu :label => proc{ I18n.t('active_admin.menu.tour_programs') }, :parent => 'Тури'
  # belongs_to :tour
  # navigation_menu :tour

  controller do
    def scoped_collection
      TourProgram.with_translations(I18n.locale)
    end
  end

  filter :tour, collection: Tour.with_translations(I18n.locale)
  filter :day_number
  filter :description

  form do |f|
    f.inputs do
      f.input :tour
      f.input :day_number
      f.input :regions, :collection => option_groups_from_collection_for_select(Country.all, :regions, :name, :id, :name, f.object.regions.map(&:id)), :input_html => { :size => 10 }
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :description, as: :html_editor
    end
    f.actions
  end
end
