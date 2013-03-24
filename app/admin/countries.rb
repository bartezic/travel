ActiveAdmin.register Country do
  index do
    column :name
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :continent
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description
      t.input :meta_description
      t.input :visa
      t.input :kitchen
      t.input :recomendation
    end
    f.buttons
  end
end
