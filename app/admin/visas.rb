ActiveAdmin.register Visa do
  menu :priority => 9, :label => proc{ I18n.t('active_admin.menu.visas') }, :parent => 'Візи'

  filter :visa_type, collection: VisaType.with_translations(I18n.locale)
  filter :country, collection: Country.with_translations(I18n.locale)
  filter :description
  filter :foreign_pas
  filter :foreign_pas_duration
  filter :foreign_pas_additional
  filter :service_pas
  filter :diplomatic_pas

  member_action :clone, :method => :put do
    o_visa = Visa.find(params[:id])
    
    n_visa = o_visa.dup
    Visa.reflect_on_all_associations(:has_many).map{|i| i.name}.each{ |i|
      o_visa.send(i).each_with_index{|as,j|
        n_visa.send(i)[j] = as.dup
      }
    }

    n_visa.save
    redirect_to :back, {:notice => I18n.t('active_admin.cloned') }
  end

  index do
    selectable_column
    id_column
    column :country
    column :visa_type
    actions do |visa|
      link_to(I18n.t('active_admin.clone'), {:action => 'clone', :id => visa }, :method => :put)
    end
  end

  form do |f|
    f.inputs do
      f.input :visa_type, as: :radio
      f.input :country
    end
    f.translated_inputs switch_locale: true do |t|
      t.input :description, as: :html_editor
      t.input :foreign_pas, as: :html_editor
      t.input :foreign_pas_duration
      t.input :foreign_pas_additional
      t.input :service_pas
      t.input :diplomatic_pas
    end
    f.actions
  end
end
