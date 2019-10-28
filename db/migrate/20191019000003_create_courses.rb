class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :author
      t.string :state
      t.integer :category_id
      t.timestamps
    end
    add_foreign_key :courses, :categories
  end
end
