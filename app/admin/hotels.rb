ActiveAdmin.register Hotel do
  menu :priority => 6, :label => proc{ I18n.t('active_admin.menu.hotels') }
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
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :amenities, as: :html_editor
      t.input :policies, as: :html_editor
      t.input :seo_meta
    end
    f.inputs "Keywords" do
      f.input :keywords
      f.has_many :keywords do |keyword|
        keyword.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
    f.buttons
  end
end
