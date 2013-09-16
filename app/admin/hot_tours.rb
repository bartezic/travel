ActiveAdmin.register HotTours do
  menu :priority => 2, :label => proc{ I18n.t('active_admin.menu.hot_tours') }
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :active do |tour|
      status_tag(tour.active.to_s)
    end
    column :photo do |a|
      div { image_tag(a.photo.asset(:thumb_150x)) if a.photo }
    end
    default_actions
  end

  form do |f|
    f.inputs do
      photo(f)
      f.input :active
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
      t.input :description
    end
    f.actions
  end
end
