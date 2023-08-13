class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :about
      t.string :groups, null: false, default: 'users'
      t.string :password_digest, null: false
      t.string :provider
      t.boolean :verified, null: false, default: false
      t.timestamps
    end
  end
end
