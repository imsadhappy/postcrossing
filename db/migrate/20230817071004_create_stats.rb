class CreateStats < ActiveRecord::Migration[7.0]
  def change
    create_table :stats do |t|
      t.string :record_type, null: false
      t.date :record_start, null: false
      t.date :record_end, null: false
      t.integer :record_count, null: false, default: 0

      t.timestamps
    end
  end
end
