ActiveAdmin.register Region do
  index do
    column :name
    column :country
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :galery
      f.input :country
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description
      t.input :meta_description
    end
    f.buttons
  end
end
