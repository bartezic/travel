ActiveAdmin.register Country do
  index do
    column :name
    column :slug
    column :continents do |a|
      a.continents.map(&:name).join(', ')
    end 
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :continents
      f.input :logo
      f.input :code
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :kitchen, as: :html_editor
      t.input :climate, as: :html_editor
      t.input :culture, as: :html_editor
      t.input :description, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :infrastructure, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
