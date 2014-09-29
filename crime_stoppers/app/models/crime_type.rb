class CrimeType < ActiveRecord::Base
  def self.find_or_create_from_name(name)
    CrimeType.where(name: name.downcase).first_or_create!
  end
end
