require "net/http"
require "json"

AdminUser.delete_all
ItemVariant.delete_all
OrderItem.delete_all
Customer.delete_all
Province.delete_all
Hst.delete_all
Gst.delete_all
Item.delete_all
Type.delete_all
Tag.delete_all
Variant.delete_all
Page.delete_all

gst0 = Gst.find_or_create_by(rate: 0.0)
gst5 = Gst.find_or_create_by(rate: 0.05)
hst0 = Hst.find_or_create_by(rate: 0.0)
hst13 = Hst.find_or_create_by(rate: 0.13)
hst15 = Hst.find_or_create_by(rate: 0.15)

Province.create(name: "Alberta", pst: 0.0, hst: hst0, gst: gst5)
Province.create(name: "British Columbia", pst: 0.07, hst: hst0, gst: gst5)
Province.create(name: "Manitoba", pst: 0.07, hst: hst0, gst: gst5)
Province.create(name: "New Brunswick", pst: 0.0, hst: hst15, gst: gst0)
Province.create(name: "Newfoundland and Labrador", pst: 0.0, hst: hst15, gst: gst0)
Province.create(name: "Northwest Territories", pst: 0.0, hst: hst0, gst: gst5)
Province.create(name: "Nova Scotia", pst: 0.0, hst: hst15, gst: gst0)
Province.create(name: "Nunavut", pst: 0.0, hst: hst0, gst: gst5)
Province.create(name: "Ontario", pst: 0.0, hst: hst13, gst: gst0)
Province.create(name: "Prince Edward Island", pst: 0.0, hst: hst15, gst: gst0)
Province.create(name: "Quebec", pst: 0.0975, hst: hst0, gst: gst5)
Province.create(name: "Saskatchewan", pst: 0.06, hst: hst0, gst: gst5)
Province.create(name: "Yukon", pst: 0.0, hst: hst0, gst: gst5)

Page.create(
  title:     "About Us",
  content:   "Nook’s Cranny has been selling Villagers the highest quality goods since 2001. Tom Nook, the founder of Nook’s Cranny, has trusted his two nephews, Timmy and Tommy, as the salesmen at the storefront. As their business demands increase, it is in the company’s best interest to expand their market to the internet. Having an online store will allow Nook’s Cranny to provide furniture, equipment, blueprints, and more to any Villager with an internet connection! ",
  permalink: "about"
)
Page.create(
  title:     "Contact Us",
  content:   "<ul><li>Email: inquire@nook.inc</li><li>Phone: 555-1289</li></ul>",
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

houseware_url = "http://acnhapi.com/v1/houseware/"
houseware_uri = URI(houseware_url)
houseware_response = Net::HTTP.get(houseware_uri)
houseware = JSON.parse(houseware_response)

houseware.keys.each do |key|
  houseware[key].each do |item|
    assign_values(item, "Houseware")
  end
end

wallmounted_url = "http://acnhapi.com/v1/wallmounted/"
wallmounted_uri = URI(wallmounted_url)
wallmounted_response = Net::HTTP.get(wallmounted_uri)
wallmounted = JSON.parse(wallmounted_response)

wallmounted.keys.each do |key|
  wallmounted[key].each do |item|
    assign_values(item, "Wallmounted")
  end
end

misc_url = "http://acnhapi.com/v1/misc/"
misc_uri = URI(misc_url)
misc_response = Net::HTTP.get(misc_uri)
misc = JSON.parse(misc_response)

misc.keys.each do |key|
  misc[key].each do |item|
    assign_values(item, "Miscellaneous")
  end
end

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end
