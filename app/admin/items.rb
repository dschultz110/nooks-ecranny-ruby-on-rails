ActiveAdmin.register Item do
  permit_params :name, :description, :price, :tag_id, :type_id
end
