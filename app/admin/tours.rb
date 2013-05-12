ActiveAdmin.register Tour do
  menu :priority => 2, :label => proc{ I18n.t('active_admin.menu.tours') }
  
  scope :all, :default => true
  scope :active do |tours|
    tours.where(active: :true)
  end
  scope :not_active do |tours|
    tours.where(active: :false)
  end

  member_action :clone, :method => :put do
    o_tour = Tour.find(params[:id])
    n_tour = o_tour.amoeba_dup
    o_tour.tour_programs.each_with_index do |tour_program, i|
      n_tour.tour_programs[i].regions = tour_program.regions 
    end
    n_tour.save
    redirect_to :back, {:notice => "Cloned!"}
  end

  index do
    selectable_column
    id_column
    column :title
    column :price do |tour|
      "#{tour.currency && tour.currency.code} #{tour.price_from}+"
    end
    column :active do |tour|
      status_tag(tour.active.to_s)
    end
    translation_status
    default_actions
    column :clone do |tour|
      div { link_to "Clone", {:action => 'clone', :id => tour }, :method => :put }
    end
  end

  form do |f|
    f.inputs do
      f.input :photo
      f.input :gallery
      f.input :currency, as: :radio
      f.input :price_from
      f.input :price_type, as: :radio, :collection => [['Room', 'room'],['Person', 'person']]
      # f.input :price_to
      f.input :active
      f.input :days, member_label: :day_of_life
      f.input :tour_types, as: :check_boxes
      f.input :food_types, as: :check_boxes
      f.input :durations, member_label: :count_of_night, as: :check_boxes
      f.input :transports, as: :check_boxes
      f.input :regions, as: :check_boxes, :collection => Country.where(code: :ua).first.regions
    end
    f.inputs "tour_programs" do
      f.has_many :tour_programs do |program|
        program.inputs do
          program.input :day_number
          program.input :regions, :collection => option_groups_from_collection_for_select(Country.all, :regions, :name, :id, :name, program.object.regions.map(&:id)), :input_html => { :size => 10 }
        end
        program.translated_inputs switch_locale: true do |t|
          t.input :description, as: :html_editor
        end
      end
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
      t.input :description, as: :html_editor
      t.input :price_list, as: :html_editor
      t.input :price_included, as: :html_editor
      t.input :price_excluded, as: :html_editor
      t.input :note, as: :html_editor
      t.input :excursions, as: :html_editor
      t.input :transport_description, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
