ActiveAdmin.register Continent do
  index do
    column :name
    column :slug
    translation_status
    default_actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description
    end
    f.buttons
  end
end
