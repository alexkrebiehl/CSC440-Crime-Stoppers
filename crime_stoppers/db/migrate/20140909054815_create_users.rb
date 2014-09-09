class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :f_name
      t.string :l_name
      t.string :password_digest
      t.date :last_login
      t.boolean :force_password
      t.boolean :is_admin

      t.timestamps
    end
  end
end
