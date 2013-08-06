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
    column :photo do |tour|
      div { image_tag(tour.cover(:thumb)) }
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :active
      f.input :cover
      f.input :cover_remote_url
      f.inputs 'Cover' do
        image_tag(f.object.cover(:thumb), id: 'hot-tour-cover')
      end
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :title
      t.input :description
    end
    f.actions
  end
end
