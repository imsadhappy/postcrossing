class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string  :email, null: false, index: { unique: true }
      t.string  :name, null: false
      t.text    :about
      t.text    :address
      t.string  :groups, null: false, default: 'users'
      t.date    :last_seen, null: false
      t.boolean :verified, null: false, default: false
      t.string  :password_digest, null: false
      t.string  :uid
      t.string  :provider
      t.timestamps
    end
  end
end
