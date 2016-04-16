class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text :message
      t.datetime :time

      t.timestamps null: false
    end
  end
end
