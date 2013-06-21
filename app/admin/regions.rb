ActiveAdmin.register Region do
  menu :priority => 5, :label => proc{ I18n.t('active_admin.menu.regions') }
  index do
    selectable_column
    id_column
    column :name
    column :photo do |region|
      div { image_tag(region.gallery.photos.first.asset(:thumb_150x)) if region.gallery && region.gallery.photos.any? }
    end
    column :country
    column :tours_to do |region|
      region.tour_programs.group_by(&:tour_id).count
    end
    column :tours_from do |region|
      region.tours.count
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
