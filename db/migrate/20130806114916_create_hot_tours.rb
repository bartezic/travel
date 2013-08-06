class CreateHotTours < ActiveRecord::Migration
  def up
    create_table :hot_tours do |t|
      t.string :title
      t.text :description
      t.boolean :active
      t.string :cover_remote_url
      t.attachment :cover

      t.timestamps
    end
    HotTours.create_translation_table!({ title: :string, description: :text })
  end
  def down
    drop_table :hot_tours
    HotTours.drop_translation_table!
  end
end
