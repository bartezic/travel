ActiveAdmin.register Country do
  index do
    column :name
    column :slug
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :continent
      f.input :logo
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :visa, as: :html_editor
      t.input :kitchen, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :meta_description
    end
    f.buttons
  end
end
