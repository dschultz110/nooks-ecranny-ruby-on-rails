require 'net/http'
require 'json'

AdminUser.delete_all
ItemVariant.delete_all
OrderItem.delete_all
Customer.delete_all
Item.delete_all
Type.delete_all
Tag.delete_all
Variant.delete_all
Page.delete_all

Page.create(
  title: "About Us",
  content: "Nook’s Cranny has been selling Villagers the highest quality goods since 2001. Tom Nook, the founder of Nook’s Cranny, has trusted his two nephews, Timmy and Tommy, as the salesmen at the storefront. As their business demands increase, it is in the company’s best interest to expand their market to the internet. Having an online store will allow Nook’s Cranny to provide furniture, equipment, blueprints, and more to any Villager with an internet connection! ",
  permalink: "about"
)
Page.create(
  title: "Contact Us",
  content: "<ul><li>Email: inquire@nook.inc</li><li>Phone: 555-1289</li></ul>",
  permalink: "contact"
)

def assign_values(item, type)
  tag = Tag.find_or_create_by(name: item["tag"])
  name = item["name"]["name-USen"]
  variant = item["variant"].nil? ? "One Colour" : item["variant"]
  image = item["image_uri"]

  ## if buy-price doesn't exist, the item is only a blueprint
  if !item["buy-price"].nil?
    type = Type.find_or_create_by(name: type)
    type = type
    price = item["buy-price"]
  else
    type = Type.find_or_create_by(name: "Blueprint")
    price = 5000
  end

  description = "This#{type.name == 'Blueprint' ? ' craftable' : ''} #{item['size'] + ' ' + name} is perfect for the #{item['hha-concept-1']} "\
      "#{item['hha-concept-2'].nil? ? '' : 'or the ' + item['hha-concept-2'] + ' '}and "\
      "#{item['isInteractive'] ? 'is interactable.' : 'is not interactable.'}"
  new_variant = Variant.find_or_create_by(name: variant)
  new_item = Item.find_or_create_by(name: name, description: description, price: price, tag: tag, type: type)
  ItemVariant.create(item: new_item, variant: new_variant, image: image)
end

houseware_url = 'http://acnhapi.com/v1/houseware/'
houseware_uri = URI(houseware_url)
houseware_response = Net::HTTP.get(houseware_uri)
houseware = JSON.parse(houseware_response)

houseware.keys.each do |key|
  for item in houseware[key] do
    assign_values(item, 'Houseware')
  end
end

wallmounted_url = 'http://acnhapi.com/v1/wallmounted/'
wallmounted_uri = URI(wallmounted_url)
wallmounted_response = Net::HTTP.get(wallmounted_uri)
wallmounted = JSON.parse(wallmounted_response)

wallmounted.keys.each do |key|
  for item in wallmounted[key] do
    assign_values(item, 'Wallmounted')
  end
end

misc_url = 'http://acnhapi.com/v1/misc/'
misc_uri = URI(misc_url)
misc_response = Net::HTTP.get(misc_uri)
misc = JSON.parse(misc_response)

misc.keys.each do |key|
  for item in misc[key] do
    assign_values(item, 'Miscellaneous')
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?