class AddMediumAndDifficultToUser < ActiveRecord::Migration[6.0]
  def change
  	    add_column :users, :medium, :string, array: true, default: []
  	    add_column :users, :difficult, :string, array: true, default: []
  end
end
