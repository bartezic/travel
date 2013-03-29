ActiveAdmin.register Hotel do
  index do
    column :name
    column :region
    column :galery
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :galery
      f.input :region
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :meta_description
    end
    f.buttons
  end
end
