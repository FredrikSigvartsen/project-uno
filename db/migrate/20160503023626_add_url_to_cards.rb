class AddUrlToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :url, :string
  end
end
