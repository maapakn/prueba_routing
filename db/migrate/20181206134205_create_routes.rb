class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :name_load
      t.integer :route
      t.date :date
      t.string :hour_start
      t.string :hour_end
      t.string :file
      t.boolean :callback, default: true

      t.timestamps
    end
  end
end
