class AddIndexToDepartments < ActiveRecord::Migration[5.1]
  def change
    add_index :departments, :title
  end
end
