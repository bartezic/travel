ActiveAdmin.register Continent do
  menu :priority => 3, :label => proc{ I18n.t('active_admin.menu.continents') }, :parent => 'Місця'
  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :seo do |a|
      raw a.seo_meta
    end
    default_actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :seo_meta
    end
    f.inputs "Keywords" do
      f.input :tags
      f.has_many :tags do |k|
        k.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
    f.actions
  end
end
