class CreateCrimeTypes < ActiveRecord::Migration
  def change
    create_table :crime_types do |t|
      t.integer :severity
      t.string :name

      t.timestamps
    end
  end
end
