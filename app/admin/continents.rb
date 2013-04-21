ActiveAdmin.register Continent do
  menu :priority => 3, :label => proc{ I18n.t('active_admin.menu.continents') }
  index do
    selectable_column
    id_column
    column :name
    column :slug
    translation_status
    default_actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :seo_meta
    end
    f.buttons
  end
end
