require 'csv'
class CrimeRecord < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
	crime_record = CrimeRecord.new
        data = row.to_s.split(',')
        location = Location.find_or_create_from_address(data[2])
        crime_type = CrimeType.find_or_create_from_name(data[3])
	crime_record.date = data[0]
	crime_record.event_id = data[1]
	crime_record.crime_type_id = crime_type.id
	crime_record.location_id = location.id
	crime_record.save
    end
  end
end
