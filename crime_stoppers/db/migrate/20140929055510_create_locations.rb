class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :Address
      t.integer :type
      t.integer :area_id

      t.timestamps
    end
  end
end
