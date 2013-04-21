ActiveAdmin.register Tour do
  menu :priority => 2, :label => proc{ I18n.t('active_admin.menu.tours') }
  
  scope :all, :default => true
  scope :active do |tours|
    tours.where(active: :true)
  end
  scope :not_active do |tours|
    tours.where(active: :false)
  end



  index do
    selectable_column
    id_column
    column :title
    column :price do |tour|
      "#{tour.currency.code} #{tour.price_from} - #{tour.price_to}"
    end
    column :active do |tour|
      status_tag(tour.active.to_s)
    end
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :photo
      f.input :currency
      f.input :price_from
      f.input :price_to
      f.input :active
      f.input :days, :member_label => :day_of_life
      f.input :tour_types
      f.input :food_types
      f.input :durations, :member_label => :count_of_night
      f.input :transports
      f.input :regions
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
      t.input :description, as: :html_editor
      t.input :transport_description, as: :html_editor
      t.input :price_list, as: :html_editor
      t.input :price_included, as: :html_editor
      t.input :price_excluded, as: :html_editor
      t.input :note, as: :html_editor
      t.input :excursions, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
