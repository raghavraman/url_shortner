class AddColumnUrlExpiration < ActiveRecord::Migration[6.1]
  def change
    add_column :urls, :expiration, :date
  end
end
