class CreateKeywords < ActiveRecord::Migration
  def up
    create_table :keywords do |t|
      t.string :title

      t.timestamps
    end
    Keyword.create_translation_table!({ title: :string })
  end
  def down
    drop_table :keywords
    Keyword.drop_translation_table!
  end
end
