class ChangeEventIdTypeToString < ActiveRecord::Migration
  def change
	change_column :crime_records, :event_id, :string
  end
end
