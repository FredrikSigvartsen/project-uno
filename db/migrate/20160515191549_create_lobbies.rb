class CreateLobbies < ActiveRecord::Migration
  def change
    create_table :lobbies do |t|

      t.timestamps null: false
    end
  end
end
