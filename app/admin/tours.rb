ActiveAdmin.register Tour do
  menu :priority => 2, :label => proc{ I18n.t('active_admin.menu.tours') }, :parent => 'Тури'

  controller do
    def create
      formating_tag_ids
      super
    end

    def update
      formating_tag_ids
      super
    end

    private
    
    def formating_tag_ids
      type = :tour
      params[type][:tag_ids] = params[type][:tag_ids].split(',') if params[type][:tag_ids]
      params[type][:tour_programs_attributes].each do |k,v|
        params[type][:tour_programs_attributes][k][:region_ids] = v[:region_ids].split(',')
      end if params[type][:tour_programs_attributes]
    end

    def twitt_tour(tour)
      img = File.new(URI.unescape("#{Rails.root}/public#{tour.photo.asset.url(:original, timestamp: false)}".split('?').first))
      url = Bitly.client.shorten(tour_url(tour), :history => 1).short_url
      title = tour.title
      descr = "Від #{tour.price_from}#{tour.currency_sym} за #{I18n.t(tour.price_type, :scope => [:tours, :price_type])} на #{tour.nights} ночей" 
      subtitle = ''

      if tour.tour_programs.any?
        regions = tour.tour_programs.map(&:regions).flatten.uniq
        subtitle = if regions.size == 1 
          "#{regions.first.name}(#{regions.first.country.name})" 
        else 
          countries = regions.map(&:country).uniq
          if countries.size == 1
            "#{countries.first.name}(#{regions.map(&:name).join('-')})"
          else
            regions.map {|region| "#{region.name}(#{region.country.name})" }.join('-')
          end
        end
      end

      ts_size = 140-(descr.size+url.size+8)
      if (title.size + subtitle.size) <= ts_size
        ts = "#{title}. #{subtitle}"
      elsif title.size < subtitle.size
        if title.size < ts_size/3
          ts = "#{title}. #{subtitle.truncate(ts_size-title.size, :separator => '..')}"
        else
          temp = title.truncate(ts_size/3, :separator => '..')
          ts = "#{temp}. #{subtitle.truncate(ts_size-temp.size, :separator => '..')}"
        end
      else
        if subtitle.size < ts_size/3
          ts = "#{title.truncate(ts_size-subtitle.size)} #{subtitle}"
        else
          temp = subtitle.truncate(ts_size/3, :separator => '..')
          ts = "#{title.truncate(ts_size-temp.size)} #{temp}"
        end
      end

      begin
        Twitter.update_with_media("#{ts}. #{descr}: #{url}", img)
      rescue
        Twitter.update("#{ts}. #{descr}: #{url}")
      end
    end

    def fb_tour(tour)
      name = [tour.title]

      if tour.tour_programs.any?
        regions = tour.tour_programs.map(&:regions).flatten.uniq
        subtitle = if regions.size == 1 
          "#{regions.first.name}(#{regions.first.country.name})" 
        else 
          countries = regions.map(&:country).uniq
          if countries.size == 1
            "#{regions.map{|region| region.name }.join('-')}(#{countries.first.name})"
          else
            regions.map{|region| "#{region.name}(#{region.country.name})" }.join('-')
          end
        end
        name.push(subtitle)
      end

      massage = [ 
        tour.title,
        "Від #{tour.price_from} #{tour.currency_sym}",
        "Тривалість: #{tour.nights} ночей",
        "Виїзди із: #{tour.regions.map(&:name).join(', ')}"].join('
      ')

      pages = FbGraph::User.me(current_admin_user.fb_token).accounts.first
      pages.feed!(
        message: massage,
        link: Bitly.client.shorten(tour_url(tour), :history => 1).short_url,
        description: tour.seo_meta,
        picture: "#{request.protocol + request.host_with_port + tour.photo.asset.url(:thumb_250x)}",
        name: name.join(' - ')
      )
    end
  end
  
  scope :all, :default => true
  scope :active do |tours|
    tours.where(active: :true)
  end
  scope :not_active do |tours|
    tours.where(active: :false)
  end

  filter :price_from
  filter :active
  filter :recommended
  filter :title
  filter :description
  filter :price_list
  filter :price_included
  filter :price_excluded
  filter :note
  filter :excursions
  filter :transport_description
  filter :seo_meta

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
    redirect_to :back, {:notice => I18n.t('active_admin.cloned') }
  end

  member_action :share, :method => :put do
    fb_tour(Tour.find(params[:id]))
    redirect_to :back, {:notice => I18n.t('active_admin.shared') }
  end

  member_action :twitt, :method => :put do
    twitt_tour(Tour.find(params[:id]))
    redirect_to :back, {:notice => I18n.t('active_admin.twited') }
  end

  batch_action :to_facebook do |selection|
    Tour.find(selection).reverse.each { |tour| fb_tour(tour) }
    redirect_to :back, {:notice => I18n.t('active_admin.shared') }
  end

  batch_action :to_twitter do |selection|
    Tour.find(selection).reverse.each { |tour| twitt_tour(tour) }
    redirect_to :back, {:notice => I18n.t('active_admin.twited') }
  end

  action_item only: :show do
    span { link_to I18n.t('active_admin.share'), {action: 'share', id: tour }, method: :put }
    span { link_to I18n.t('active_admin.clone'), {action: 'clone', id: tour }, method: :put }
    span { link_to I18n.t('active_admin.twitt'), {action: 'twitt', id: tour }, method: :put }
  end

  index do
    selectable_column
    id_column
    column :title
    column :photo do |tour|
      div { image_tag tour.photo.asset(:thumb_150x) }
    end
    column :price do |tour|
      "#{tour.price_from}#{tour.currency_sym} +"
    end
    column :days do |tour|
      tour.days.size
    end
    column :active do |tour|
      status_tag(tour.active.to_s)
    end
    column :seo do |tour|
      raw tour.seo_meta
    end
    actions do |tour|
      link_to(I18n.t('active_admin.clone'), {action: 'clone', id: tour }, method: :put) +
      link_to(I18n.t('active_admin.share'), {action: 'share', id: tour }, method: :put) +
      link_to(I18n.t('active_admin.twitt'), {action: 'twitt', id: tour }, method: :put)
    end
  end

  form do |f|
    f.inputs do
      photo(f)
      gallery(f)
      f.input :currency, as: :radio, collection: Currency.with_translations(I18n.locale)
      f.input :price_from
      f.input :price_type, as: :radio, collection: [
        [I18n.t('active_admin.room'), 'room'],
        [I18n.t('active_admin.person'), 'person']
      ]
      # f.input :price_to
      f.input :active
      f.input :recommended
      f.input :days, member_label: :day_of_life, input_html: { size: 30 }
      f.input :tour_types, as: :check_boxes, collection: TourType.with_translations(I18n.locale)
      f.input :food_types, as: :check_boxes, collection: FoodType.with_translations(I18n.locale)
      f.input :durations, member_label: :count_of_night, as: :check_boxes
      f.input :transports, as: :check_boxes, collection: Transport.with_translations(I18n.locale)
      f.input :regions, as: :check_boxes, collection: Country.where(code: :ua).first.regions.with_translations(I18n.locale)
    end
    f.inputs "tour_programs" do
      f.has_many :tour_programs do |program|
        program.input :day_number
        regions(program)
        program.input(:_destroy, as: :boolean, label: "Destroy?") if program.object
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
    keywords(f)
    f.actions
  end
end
