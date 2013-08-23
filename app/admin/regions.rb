ActiveAdmin.register Region do
  menu :priority => 5, :label => proc{ I18n.t('active_admin.menu.regions') }, :parent => 'Місця'

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
      type = :region
      params[type][:tag_ids] = params[type][:tag_ids].split(',') if params[type][:tag_ids]
    end
  end
  
  filter :country
  filter :name
  filter :description
  filter :recomendation
  filter :infrastructure
  filter :seo_meta

  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag(a.photo.asset(:thumb_150x)) if a.photo }
    end
    column :country
    column :tours_to do |region|
      region.tour_programs.group_by(&:tour_id).size
    end
    column :tours_from do |region|
      region.tours.size
    end
    column :seo do |a|
      raw a.seo_meta
    end
    default_actions
  end

  form do |f|
    f.inputs do
      photo(f)
      gallery(f)
      geo_block(f)
      f.input :country
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :recomendation, as: :html_editor
      t.input :infrastructure, as: :html_editor
      t.input :seo_meta
    end
    keywords(f)
    f.actions
  end
end
