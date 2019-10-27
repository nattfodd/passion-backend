class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, index: { unique: true }
      t.string :state
      t.integer :vertical_id
      t.timestamps
    end
    add_foreign_key :categories, :verticals
  end
end
