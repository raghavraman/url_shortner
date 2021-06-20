class CreateUrlLog < ActiveRecord::Migration[6.1]
  def change
    create_table :url_logs do |t|
      t.integer :url_id
      t.time :redirection_time
      t.timestamps
    end

    add_foreign_key :url_logs, :urls
  end
end
