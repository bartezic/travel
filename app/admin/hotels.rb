ActiveAdmin.register Hotel do
  menu :priority => 6, :label => proc{ I18n.t('active_admin.menu.hotels') }, :parent => 'Місця'
  
  filter :region, collection: Region.with_translations(I18n.locale)
  filter :name
  filter :description
  filter :amenities
  filter :policies
  filter :seo_meta


  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag(a.gallery.photos.first.asset(:thumb_150x)) if a.gallery && a.gallery.photos.any? }
    end
    column :star
    column :site
    column :region
    column :gallery
    column :seo do |a|
      raw a.seo_meta
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :gallery
      f.input :region
      f.input :star
      f.input :address
      f.input :phone
      f.input :email
      f.input :site
      f.input :geo_input, input_html: { class: :geo_input2 }
      f.input :geo, input_html: { class: :geo2 }
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :amenities, as: :html_editor
      t.input :policies, as: :html_editor
      t.input :seo_meta
    end
    f.inputs "Keywords" do
      if f.object.tags && f.object.tags.any?
        f.input :tags, as: :string, input_html: { 
          class: :tag2, 
          value: '', 
          data: { 
            tags: f.object.tags.map{ |tag| 
              { text: tag.title, id: tag.id } 
            }.to_json
          } 
        }
      else
        f.input :tags, as: :string, input_html: { class: :tag2, value: '' }
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
