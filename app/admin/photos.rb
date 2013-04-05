ActiveAdmin.register Photo do
  index do
    column :title
    column :gallery
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :gallery
      f.input :asset
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
