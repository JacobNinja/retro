require File.expand_path('./../connection', __FILE__)

## USERS
user_id = DB[:users].insert(name: "test", password: "123", figure: "1150120723280013050122525", sex: "M", mission: "mission")

## CATEGORIES
public_category_id = DB[:room_categories].insert(type: 0, name: "Public Category", parent: 0)
private_category_id = DB[:room_categories].insert(type: 2, name: "Private Category", parent: 0)

## ROOM TYPES
public_lounge_type_id = DB[:room_types].insert(name: "Public Welcome Lounge", max_guests: 100, ccts: 'hh_room_nlobby', model: 'newbie_lobby', start_x: 2, start_y: 11, start_z: 0, guest: 0, max_ascend: 1.5, max_descend: 4.0, user_type: 0, heightmap: 'xxxxxxxxxxxxxxxx000000|xxxxx0xxxxxxxxxx000000|xxxxx00000000xxx000000|xxxxx000000000xx000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|xxxxx000000000000000xx|xxxxx000000000000000xx|x0000000000000000000xx|x0000000000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxxx0000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxx000000000000xxxxx|xxxxx000000000000xxxxx')
private_type_id = DB[:room_types].insert(name: "Guest Model A", max_guests: 25, ccts: '0', model: 'model_a', start_x: 3, start_y: 5, start_z: 0, guest: 1, max_ascend: 1.5, max_descend: 4.0, user_type: 1, heightmap: 'xxxxxxxxxxxx|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxxxxxxxxxx|xxxxxxxxxxxx')

## ROOMS
DB[:rooms].insert(name: "Welcome Lounge", description: "test", category_id: public_category_id, type_id: public_lounge_type_id, status: 'open')
my_room_id = DB[:rooms].insert(name: "test", description: "test", category_id: private_category_id, type_id: private_type_id, status: 'open', owner_id: user_id)

## FURNI DEFINITIONS
furni_id = DB[:furni_definitions].insert(sprite: 'bardeskcorner_polyfon', flags: 'MO', hand_type: 'S', width: 1, length: 1, col: "0,0,0", height: 1.0)

## ITEMS
DB[:items].insert(user_id: user_id, furni_definition_id: furni_id)