class RemoveItemsFromOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :item_id, :integer
  end
end
