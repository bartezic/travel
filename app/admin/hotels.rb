ActiveAdmin.register Hotel do
  menu :priority => 6, :label => proc{ I18n.t('active_admin.menu.hotels') }, :parent => 'Місця'
  
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
      type = :hotel
      params[type][:tag_ids] = params[type][:tag_ids].split(',') if params[type][:tag_ids]
    end
  end
  
  filter :region
  filter :name
  filter :description
  filter :amenities
  filter :policies
  filter :seo_meta


  index do
    selectable_column
    id_column
    column :name
    column :photo do |a|
      div { image_tag(a.photo.asset(:thumb_150x)) if a.photo }
    end
    column :star
    column :site
    column :region
    column :gallery
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
      region(f)
      f.input :star
      f.input :address
      f.input :phone
      f.input :email
      f.input :site
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :name
      t.input :description, as: :html_editor
      t.input :amenities, as: :html_editor
      t.input :policies, as: :html_editor
      t.input :seo_meta
    end
    keywords(f)
    f.actions
  end
end
