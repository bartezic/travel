ActiveAdmin.register Visa do
  index do
    column :visa_type
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :visa_type
      f.input :country
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :description
      t.input :foreign_pas
      t.input :foreign_pas_duration
      t.input :foreign_pas_additional
      t.input :service_pas
      t.input :diplomatic_pas
    end
    f.buttons
  end
end
