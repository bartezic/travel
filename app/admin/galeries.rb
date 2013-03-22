ActiveAdmin.register Galery do
  index do
    column :title
    translation_status
    default_actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
