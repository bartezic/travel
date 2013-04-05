class CreateVisaTypes < ActiveRecord::Migration
  def up
    create_table :visa_types do |t|
      t.string :title

      t.timestamps
    end
    VisaType.create_translation_table!({ title: :string })
  end

  def down
    drop_table :visa_types
    VisaType.drop_translation_table! 
  end
end
