class CreateCrimeRecords < ActiveRecord::Migration
  def change
    create_table :crime_records do |t|
      t.integer :location_id
      t.integer :crime_type_id
      t.integer :event_id
      t.date :date

      t.timestamps
    end
  end
end
