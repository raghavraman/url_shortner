class AddColumnUrlIsDeleted < ActiveRecord::Migration[6.1]
  def change
    add_column :urls, :is_deleted, :boolean
  end
end
