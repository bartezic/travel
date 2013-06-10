ActiveAdmin.register Country do
  menu :priority => 4, :label => proc{ I18n.t('active_admin.menu.countries') }
  
  scope :all, :default => true
  proc{ 
    Continent.all.each do |continent|
      scope continent.slug do |countries|
        continent.countries
      end
    end
  }.call

  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag a.photo.asset(:thumb_150x) if a.photo }
    end
    column :slug
    column :code
    column :continents do |a|
      a.continents.map(&:name).join(', ')
    end 
    column :seo do |a|
      raw a.seo_meta
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :continents
      f.input :photo, as: :select, collection: Photo.all.sort_by(&:title).map{ |photo|
        [photo.title, photo.id, { :'data-thumb' => photo.asset(:thumb_150x) }]
      }
      f.input :code
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :kitchen, as: :html_editor
      t.input :climate, as: :html_editor
      t.input :culture, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :infrastructure, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
