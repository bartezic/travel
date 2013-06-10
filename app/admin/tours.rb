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
    
    n_tour = o_tour.dup
    Tour.reflect_on_all_associations(:has_many).map{|i| i.name}.each{ |i|
      o_tour.send(i).each_with_index{|as,j|
        n_tour.send(i)[j] = as.dup
      }
    }
    Tour.reflect_on_all_associations(:has_and_belongs_to_many).map{|i| i.name}.each{ |i|
      o_tour.send(i).each_with_index{|as,j|
        n_tour.send(i)[j] = as
      }
    }
    o_tour.tour_programs.each_with_index do |tour_program, i|
      n_tour.tour_programs[i].regions = tour_program.regions
      tour_program.translations.each_with_index do |translation, j|
        n_tour.tour_programs[i].translations[j] = translation.dup
      end
    end
    
    n_tour.save
    redirect_to :back, {:notice => "Cloned!"}
  end

  member_action :share, :method => :put do
    tour = Tour.find(params[:id])
    bitly = Bitly.new('o_7bdn4eemnu', 'R_95733437b5cb4c07b976dfa185964cab')

    name = [tour.title]

    if tour.tour_programs.any? && tour.tour_programs.first.regions.any?
      regions = tour.tour_programs.map { |program| program.regions }.flatten.uniq
      name.push(regions.size == 1 ? "#{regions.first.name} (#{regions.first.country.name})" : regions.map {|region| "#{region.name} (#{region.country.name})" }.join(' - '))
    end

    massage = [ tour.title,
                "Від #{tour.price_from} #{tour.currency && tour.currency.code}",
                "Тривалість: #{tour.durations.map(&:count_of_night).join(', ')} ночей",
                "Виїзди із: #{tour.regions.map(&:name).join(', ')}"]

    pages = FbGraph::User.me(current_admin_user.fb_token).accounts.first
    pages.feed!(
      :message => massage.join('
        '),
      :link => bitly.shorten(tour_url(tour), :history => 1).short_url,
      :description => tour.seo_meta,
      :picture => "#{request.protocol + request.host_with_port + tour.photo.asset.url(:thumb_250x)}",
      :name => name.join(' - ')
    )
    
    redirect_to :back, {:notice => "Shared!"}
  end

  action_item :only => :show do
    span { link_to "Share", {:action => 'share', :id => tour }, :method => :put }
    span { link_to "Clone", {:action => 'clone', :id => tour }, :method => :put }
  end

  index do
    selectable_column
    id_column
    column :title
    column :photo do |tour|
      div { image_tag tour.photo.asset(:thumb_150x) }
    end
    column :price do |tour|
      "#{tour.currency && tour.currency.code} #{tour.price_from}+"
    end
    column :active do |tour|
      status_tag(tour.active.to_s)
    end
    column :seo do |tour|
      raw tour.seo_meta
    end
    actions do |tour|
      link_to("Clone", {:action => 'clone', :id => tour }, :method => :put) +
      link_to("Share", {:action => 'share', :id => tour }, :method => :put)
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
