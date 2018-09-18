require("pry")
require_relative("./models/property")

Property.delete_all()

property1 = Property.new({
  'address' => "10 Downing Street",
  'value' => 4500,
  'bedrooms' => 12,
  'year_built' => 1850})

property2 = Property.new({
    "address" => "Buckingham Palace",
    "value" => 99000,
    "bedrooms" => 36,
    "year_built" => 1720})

property3 = Property.new({
  "address" => "Balmoral, Scotland",
  "value" => 88000,
  "bedrooms" => 40,
  "year_built" => 1620})

property1.save()

property2.save()

property3.save()

property2.delete()

property1.bedrooms = 20

property1.update()

found = Property.find_by_id(property3.id)

addy = Property.find_by_address("10 Downing Street")







binding.pry
nil
