require File.expand_path('./../connection', __FILE__)

lines = File.foreach("/Users/jacobr/learn/thor/trunk/ThorServer/Data/Schema.sql")

table_re = /INSERT INTO (\w+)/
values_re = /VALUES\((.*)\)/

hsh = {}
loop do
  line = lines.next
  if match = line.match(table_re)
    table_name = match.captures.first
    captured_values = lines.next.match(values_re).captures.first
    values = eval("[#{captured_values}]")
    hsh[table_name] ||= []
    hsh[table_name] << values
  end
end

## seed the data

furni_definitions = hsh["FurniDefinitions"].each_with_object({}) do |(id, sprite, flags, width, length, col, height, hand_type, var_type, action_height, can_trade, public_furni), f_hsh|
  f_hsh[id] = DB[:furni_definitions].insert(sprite: sprite, flags: flags, width: width, length: length, col: col, height: height, hand_type: hand_type, var_type: var_type, action_height: action_height, can_trade: can_trade, public: public_furni)
end
furni_definitions_by_code = {}
furni_definitions_by_code["purchase_barchair_silo"] = DB[:furni_definitions].insert(sprite: "barchair_silo", flags: 'S', width: 2, length: 1, col: "0,0,0", height: 1, hand_type: 'S', var_type: 0, action_height: 0, can_trade: 1, public: 0)

catalog_pages = hsh["CataloguePages"].each_with_object({}) do |(id, name, visible_name, order, layout, image_title, side_image, description, label, additional, staff_only), c_hsh|
  c_hsh[id] = DB[:catalog_pages].insert(name: name, visible_name: visible_name, order: order, layout: layout, image_title: image_title, side_image: side_image, description: description, label: label, additional: additional, staff_only: staff_only)
end

hsh["CatalogueItems"].each do |(id, furni_type, page_id, cost, purchase_code)|
  furni_definition_id = furni_definitions[furni_type] || furni_definitions_by_code[purchase_code]
  DB[:catalog_items].insert(furni_definition_id: furni_definition_id, catalog_page_id: catalog_pages[page_id], cost: cost, purchase_code: purchase_code)
end

hsh["RoomTypes"].each do |(id, friendly_name, model, heightmap, start_x, start_y, start_z, guest, _, ccts, user_type, max_ascend, max_descend)|
  DB[:room_types].insert(name: friendly_name, heightmap: heightmap, start_x: start_x, start_y: start_y, start_z: start_z, guest: guest, ccts: ccts, user_type: user_type, max_ascend: max_ascend, max_descend: max_descend, model: model)
end

hsh["RoomCategories"].each do |(id, name, parent_id, type, can_trade, visible, player_category, order, system_cat)|
  DB[:room_categories].insert(id: id, name: name, parent: parent_id, type: type)
end


## USERS
user_id = DB[:users].insert(name: "test", password: "123", figure: "8000119001280152950125516", sex: "M", mission: "mission")

## CATEGORIES
#public_category_id = DB[:room_categories].insert(id: 3, type: 0, name: "Public Categories", parent: 0)
#private_category_id = DB[:room_categories].insert(id: 4, type: 2, name: "Private Categories", parent: 0)
#DB[:room_categories].insert(type: 2, name: "No Category", parent: private_category_id)
outside_category_id = DB[:room_categories].first(name: "Staff Recommended Rooms")[:id]
trade_room_category_id = DB[:room_categories].first(name: "Trade Rooms")[:id]

## Create a new room
model_a_id = DB[:room_types].first(:model => "model_a")[:id]
my_room_id = DB[:rooms].insert(name: "test", description: "test", category_id: trade_room_category_id, type_id: model_a_id, status: 0, owner_id: user_id)

welcome_id = DB[:room_types].first(model: "newbie_lobby")[:id]
welcome_room_id = DB[:rooms].insert(name: "Welcome lounge", description: "test", category_id: outside_category_id, type_id: welcome_id, status: 0)


## Create some items for user
#DB[:items].insert(user_id: user_id, furni_definition_id: furni_id)
