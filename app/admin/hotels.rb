ActiveAdmin.register Hotel do
  index do
    column :name
    column :region
    column :gallery
    translation_status
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
      t.input :amenities, as: :html_editor
      t.input :policies, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
