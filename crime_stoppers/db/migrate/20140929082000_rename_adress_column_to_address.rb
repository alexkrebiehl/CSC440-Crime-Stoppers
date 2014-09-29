class RenameAdressColumnToAddress < ActiveRecord::Migration
  def change
	rename_column :locations, :Address, :address
  end
end
