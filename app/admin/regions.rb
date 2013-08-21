ActiveAdmin.register Region do
  menu :priority => 5, :label => proc{ I18n.t('active_admin.menu.regions') }, :parent => 'Місця'

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
      type = :region
      params[type][:tag_ids] = params[type][:tag_ids].split(',') if params[type][:tag_ids]
    end
  end
  
  filter :country, collection: Country.with_translations(I18n.locale).map do |country| 
    [country.id, country.name]
  end
  filter :name
  filter :description
  filter :recomendation
  filter :infrastructure
  filter :seo_meta

  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag(a.photo.asset(:thumb_150x)) if a.photo }
    end
    column :country
    column :tours_to do |region|
      region.tour_programs.group_by(&:tour_id).size
    end
    column :tours_from do |region|
      region.tours.size
    end
    column :seo do |a|
      raw a.seo_meta
    end
    default_actions
  end

  form do |f|
    f.inputs do
      if f.object.photo
        f.input :photo_id, as: :string, input_html: { 
          class: :photo2, 
          data: { 
            text: f.object.photo.title, 
            id: f.object.photo.id, 
            thumb: f.object.photo.asset(:thumb_150x) 
          }
        }
      else
        f.input :photo_id, as: :string, input_html: { class: :photo2 }
      end
      f.input :gallery
      f.input :country
      f.input :geo_input, input_html: { class: :geo_input2 }
      f.input :geo, input_html: { class: :geo2 }
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :infrastructure, as: :html_editor
      t.input :seo_meta
    end
    f.inputs "Keywords" do
      if f.object.tags && f.object.tags.any?
        f.input :tag_ids, as: :string, input_html: { 
          class: :tag2, 
          value: '', 
          data: { 
            tags: f.object.tags.map{ |tag| 
              { text: tag.title, id: tag.id } 
            }.to_json
          } 
        }
      else
        f.input :tag_ids, as: :string, input_html: { class: :tag2, value: '' }
      end
      f.has_many :tags do |k|
        k.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
    f.actions
  end
end
