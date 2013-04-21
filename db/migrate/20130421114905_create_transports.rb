class CreateTransports < ActiveRecord::Migration
  def up
    create_table :transports do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
    Transport.create_translation_table!({ title: :string })
  end
  def down
    drop_table :transports
    Transport.drop_translation_table!
  end
end
