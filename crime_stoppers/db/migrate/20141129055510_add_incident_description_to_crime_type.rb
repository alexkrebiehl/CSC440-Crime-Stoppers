class AddIncidentDescriptionToCrimeType < ActiveRecord::Migration
  def change
    add_column :crime_types, :incident_description, :string
  end
end
