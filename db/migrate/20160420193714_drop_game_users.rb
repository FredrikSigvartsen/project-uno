class DropGameUsers < ActiveRecord::Migration
  def up
    drop_table :game_users
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
