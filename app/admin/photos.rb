ActiveAdmin.register Photo do
  menu :priority => 8, :label => proc{ I18n.t('active_admin.menu.photos') }

  filter :id
  filter :meta_galleries, :as => :select, :collection => proc{ Gallery.all }
  filter :meta_countries, :as => :select, :collection => proc{ Country.all }
  filter :title
  filter :slug

  index do
    selectable_column
    id_column
    column :title
    column :galleries do |photo|
      photo.galleries.each{ |gallery| div { link_to gallery.title, [:admin, gallery] }}
    end
    column :countries do |photo|
      photo.countries.each{ |country| div { link_to country.name, [:admin, country] }}
    end
    column :tours do |photo|
      photo.tours.each{ |tour| div { link_to tour.title, [:admin, tour] }}
    end
    column :asset do |photo|
      div { image_tag photo.asset(:thumb_150x) }
      div :class => 'asset' do
        photo.asset(:thumb_150x)
      end
    end
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :asset
      f.input :asset_remote_url
      f.inputs 'Photo' do
        image_tag photo.asset(:thumb_150x), :id => "photoAsset"
      end
      f.input :galleries, as: :check_boxes
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
