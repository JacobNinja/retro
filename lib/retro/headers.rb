module Retro

  SERVER_HEADERS = {
      4 => :login, # @D
      5 => :check_version, # @E
      6 => :shockwave_id, # @F
      7 => :user_details, # @G
      8 => :credits, # @H
      26 => :hc_info, # @Z
      157 => :badges, # B]
      12 => :messenger_init, # @L
      26 => :club_habbo, # @Z
  }

  CLIENT_HEADERS = {
      :public_key => 1,
      :encryption_begin => 50,
      :rights => 2,
      :login_ok => 3,
      :credits => 6,
      :greeting => 0,
      :name => 5,
      :club_habbo => 7,
  }

end