class CreateUrl < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :orginalURL, null: false
      t.string :key, null: false, limit: 4
      t.timestamps
    end
  end
end
