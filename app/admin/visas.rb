ActiveAdmin.register Visa do
  index do
    column :visa_type
    translation_status
    default_actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :description
    end
    f.buttons
  end
end
