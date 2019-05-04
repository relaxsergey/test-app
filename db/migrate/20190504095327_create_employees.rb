class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.boolean :active, default: false
      t.belongs_to :department, index: true

      t.timestamps
    end
  end
end
