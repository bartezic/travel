ActiveAdmin.register Region do
  menu :priority => 5, :label => proc{ I18n.t('active_admin.menu.regions') }
  index do
    selectable_column
    id_column
    column :name
    column :country
    translation_status
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :gallery
      f.input :country
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :infrastructure, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
