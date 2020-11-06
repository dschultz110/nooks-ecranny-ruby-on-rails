ActiveAdmin.register Item do
  permit_params :name, :description, :price, :tag_id, :type_id, item_variants_attributes: [:id, :item_id, :variant_id, :image, :_destroy]

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :price
    column :tag
    column :type
    column :variants do |item|
      item.variants.map { |i| i.name }.join(", ").html_safe
    end
    column :created_at
    column :updated_at
    actions
  end

  show do |item|
    attributes_table do
      row :name
      row :description
      row :price
      row :tag
      row :type
      row :variants do |item|
        item.variants.map { |i| i.name }.join(", ").html_safe
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Item" do
      f.input :name
      f.input :description
      f.input :price
      f.has_many :item_variants, allow_destroy: true do |n_f|
        n_f.input :variant
        n_f.input :image
      end
    end

    f.actions
  end
end
