ActiveAdmin.register RequestAction do
  menu :label => proc{ I18n.t('active_admin.menu.request_action') }

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :countries
    column :departure do |i|
      "#{i.departure_date} на #{i.duration} ночей"
    end
    column :budget do |i|
      "#{i.currency && i.currency.code} #{i.budget}"
    end
    column :persons do |i|
      div { "#{i.adults || 0} дорослих" }
      div { "#{i.childrens || 0} дітей" }
    end
    column :tour_types do |i|
      raw i.tour_types.map(&:title).join('<br/>')
    end
    column :transports do |i|
      raw i.transports.map(&:title).join('<br/>')
    end
    column :node
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :countries
      f.input :response_type
      f.input :subscribe
      f.input :node
      f.input :budget
      f.input :duration
      f.input :departure_date
      f.input :adults
      f.input :childrens
      f.input :currency
      f.input :transports
      f.input :tour_types
    end
    f.buttons
  end
end
