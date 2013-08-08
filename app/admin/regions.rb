ActiveAdmin.register Region do
  menu :priority => 5, :label => proc{ I18n.t('active_admin.menu.regions') }, :parent => 'Місця'

  filter :country, collection: Country.with_translations(I18n.locale)
  filter :name
  filter :description
  filter :recomendation
  filter :infrastructure
  filter :seo_meta

  index do
    selectable_column
    id_column
    column :name
    column :photo do |region|
      photo = region.gallery && region.gallery.photos.limit(1).try(:first)
      div { image_tag(photo.asset(:thumb_150x)) if photo }
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
      f.input :gallery
      f.input :country
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :infrastructure, as: :html_editor
      t.input :seo_meta
    end
    f.inputs "Keywords" do
      f.input :tags
      f.has_many :tags do |k|
        k.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
    f.actions
  end
end
