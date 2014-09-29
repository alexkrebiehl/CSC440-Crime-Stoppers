class Location < ActiveRecord::Base
  def self.find_or_create_from_address(address)
    Location.where(address: address.downcase).first_or_create!
  end
end
