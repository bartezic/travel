ActiveAdmin.register Attraction do
  menu :priority => 6, :label => proc{ I18n.t('active_admin.menu.attractions') }, :parent => 'Місця'
  
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
      type = :attraction
      params[type][:tag_ids] = params[type][:tag_ids].split(',') if params[type][:tag_ids]
    end
  end

  filter :region
  filter :name
  filter :description
  filter :seo_meta

  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag(a.photo.asset(:thumb_150x)) if a.photo }
    end
    column :region
    column :gallery
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
      f.input :region
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
