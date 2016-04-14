class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :host_id
      t.string :description
    end
  end
end
