ActiveAdmin.register Attraction do
  menu :priority => 6, :label => proc{ I18n.t('active_admin.menu.attractions') }, :parent => 'Місця'

  filter :region, collection: Region.with_translations(I18n.locale)
  filter :name
  filter :description
  filter :seo_meta

  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      photo = a.gallery && a.gallery.photos.limit(1).try(:first)
      div { image_tag(photo.asset(:thumb_150x)) if photo }
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
      f.input :gallery
      f.input :region
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
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
