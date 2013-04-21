ActiveAdmin.register Hotel do
  menu :priority => 6, :label => proc{ I18n.t('active_admin.menu.hotels') }
  index do
    selectable_column
    id_column
    column :name
    column :star
    column :site
    column :region
    column :gallery
    translation_status
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
    f.buttons
  end
end
