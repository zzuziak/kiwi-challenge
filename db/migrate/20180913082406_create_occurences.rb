class CreateOccurences < ActiveRecord::Migration[5.2]
  def change
    create_table :occurences do |t|
      t.date :date
      t.string :device_status
      t.string :device_type
      t.string :device_id

      t.timestamps
    end
  end
end
