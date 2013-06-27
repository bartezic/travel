class CreateRequestActions < ActiveRecord::Migration
  def change
    create_table :request_actions do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :countries
      t.string :response_type
      t.integer :budget
      t.integer :duration
      t.integer :adults
      t.integer :childrens
      t.integer :currency_id
      t.date :departure_date
      t.boolean :subscribe
      t.text :node

      t.timestamps
    end
    create_table :request_actions_transports do |t|
      t.integer :request_action_id
      t.integer :transport_id
    end
    create_table :request_actions_tour_types do |t|
      t.integer :request_action_id
      t.integer :tour_type_id
    end
  end
end
