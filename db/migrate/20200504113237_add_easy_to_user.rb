class AddEasyToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :easy, :string, array: true, default: []
  end
end
