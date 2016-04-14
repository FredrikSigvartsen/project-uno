class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :value
      t.string :color
    end
  end
end
