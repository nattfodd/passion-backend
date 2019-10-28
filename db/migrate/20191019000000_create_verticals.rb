class CreateVerticals < ActiveRecord::Migration[5.2]
  def change
    create_table :verticals do |t|
      t.string :name, index: { unique: true }
      t.timestamps
    end
  end
end
