require File.expand_path('./../retro/session', __FILE__)
require File.expand_path('./../retro/server', __FILE__)
#require File.expand_path('./../retro/client', __FILE__)
require File.expand_path('./../retro/attrs', __FILE__)
require File.expand_path('./../retro/user', __FILE__)
require File.expand_path('./../retro/furni_definition', __FILE__)
require File.expand_path('./../retro/item', __FILE__)
require File.expand_path('./../retro/catalog_page', __FILE__)
require File.expand_path('./../retro/catalog_item', __FILE__)
require File.expand_path('./../retro/rooms/room', __FILE__)
require File.expand_path('./../retro/rooms/room_category', __FILE__)
require File.expand_path('./../retro/rooms/room_type', __FILE__)
require File.expand_path('./../retro/handlers/all', __FILE__)
require File.expand_path('./../retro/headers', __FILE__)
require File.expand_path('./../retro/encoding/b64', __FILE__)
require File.expand_path('./../retro/encoding/vl64', __FILE__)
require File.expand_path('./../retro/encryption/rc4', __FILE__)
require File.expand_path('./../retro/client/message', __FILE__)
require File.expand_path('./../retro/client/duration_message', __FILE__)
require File.expand_path('./../retro/client/message_factory', __FILE__)
require File.expand_path('./../retro/server_message', __FILE__)

#require File.expand_path('./../../database/connection', __FILE__)

module Retro

  def self.reload_handlers
    Dir[File.expand_path('./../retro/handlers', __FILE__) + "/*.rb"].each do |file|
      load file unless file.end_with? "all.rb"
    end
    load File.expand_path('./../retro/headers.rb', __FILE__)
  end

end
