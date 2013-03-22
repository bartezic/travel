ActiveAdmin.register Photo do
  index do
    column :title
    column :galery
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :galery
      f.input :asset
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.buttons
  end
end
