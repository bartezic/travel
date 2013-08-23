# encoding: utf-8
ActiveAdmin.register Country do
  menu :priority => 4, :label => proc{ I18n.t('active_admin.menu.countries') }, :parent => 'Місця'

  controller do
    def create
      formating_tag_ids
      super
    end

    def update
      formating_tag_ids
      super
    end

    private
    def formating_tag_ids
      type = :country
      params[type][:tag_ids] = params[type][:tag_ids].split(',') if params[type][:tag_ids]
    end
  end


  scope :all, :default => true
  # Continent.with_translations(I18n.locale).each do |continent|
  #   scope continent.name do |countries|
  #     continent.countries
  #   end
  # end

  # filter :continents, as: :select, collection: Continent.with_translations(I18n.locale)
  filter :name
  filter :description
  filter :code

  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag a.photo.asset(:thumb_150x) if a.photo }
    end
    column :slug
    column :code
    column :continents do |a|
      a.continents.map(&:name).join(', ')
    end 
    column :seo do |a|
      raw a.seo_meta
    end
    default_actions
  end

  form do |f|
    f.inputs do
      photo(f)
      geo_block(f)
      f.input :continents
      f.input :code
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :kitchen, as: :html_editor
      t.input :climate, as: :html_editor
      t.input :culture, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :infrastructure, as: :html_editor
      t.input :seo_meta
    end
    keywords(f)
    f.actions
  end
end
