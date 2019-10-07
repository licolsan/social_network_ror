class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|

      t.string :provider
      t.string :email
      t.string :name
      t.string :avatar
      t.string :password
      t.datetime :date_of_birth

      t.timestamps
    end
  end
end
