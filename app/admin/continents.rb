ActiveAdmin.register Continent do
  menu :priority => 3, :label => proc{ I18n.t('active_admin.menu.continents') }
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
      f.input :keywords
      f.has_many :keywords do |keyword|
        keyword.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
    f.buttons
  end
end
