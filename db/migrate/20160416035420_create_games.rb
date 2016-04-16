class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :host_id

      t.timestamps null: false
    end
  end
end
