ActiveAdmin.register Continent do
  menu :priority => 3, :label => proc{ I18n.t('active_admin.menu.continents') }, :parent => 'Місця'
  
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
      type = :continent
      params[type][:tag_ids] = params[type][:tag_ids].split(',') if params[type][:tag_ids]
    end
  end
  
  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :seo do |a|
      raw a.seo_meta
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :geo_input, input_html: { class: :geo_input2 }
      f.input :geo, input_html: { class: :geo2 }
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
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
