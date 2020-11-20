class RemoveVariantsFromOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :variant_id, :integer
    add_column :order_items, :item_variant_id, :integer
  end
end
