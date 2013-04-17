class AddColumnsToVisa < ActiveRecord::Migration
  def change
    add_column :visas, :foreign_pas, :text
    add_column :visas, :foreign_pas_duration, :string
    add_column :visas, :foreign_pas_additional, :string
    add_column :visas, :service_pas, :string
    add_column :visas, :diplomatic_pas, :string

    add_column :visa_translations, :foreign_pas, :text
    add_column :visa_translations, :foreign_pas_duration, :string
    add_column :visa_translations, :foreign_pas_additional, :string
    add_column :visa_translations, :service_pas, :string
    add_column :visa_translations, :diplomatic_pas, :string
  end
end
