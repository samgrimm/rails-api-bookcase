class AddPublisherIdToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :publisher_id, :string
    add_index :books, :publisher_id
  end
end
