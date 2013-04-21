class CreateCurrencies < ActiveRecord::Migration
  def up
    create_table :currencies do |t|
      t.string :title
      t.string :code

      t.timestamps
    end
    Currency.create_translation_table!({ title: :string })
  end
  def down
    drop_table :currencies
    Currency.drop_translation_table!
  end
end
