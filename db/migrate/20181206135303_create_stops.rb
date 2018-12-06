class CreateStops < ActiveRecord::Migration[5.2]
  def change
    create_table :stops do |t|
      t.references :route, foreign_key: true
      t.string :hour_arrival
      t.integer :load
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
