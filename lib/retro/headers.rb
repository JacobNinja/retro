module Retro
  module Handlers

    SERVER_HEADERS = {
        2 => RoomDirectory, # @B
        4 => Login, # @D
        5 => CheckVersion, # @E
        6 => Shockwave, # @F
        7 => UserDetails, # @G
        8 => Credits, # @H
        52 => Chat, # @t
        57 => TryFlat, # @y
        59 => GotoFlat, # @{
        60 => Heightmap, # @|
        61 => Users, # @}
        62 => Objects, # @~
        63 => Items, # @\x7F
        64 => GStat, # A@
        88 => Stop, # AX
        115 => GoAway, # As
        126 => RoomAd, # A~
        157 => Badges, # B]
        12 => MessengerInit, # @L
        26 => ClubHabbo, # @Z
        150 => Navigate, # BV
        151 => UserFlatCats, # BW
        16 => SearchRooms, # @P
        18 => FavoriteRooms, # @R
        21 => RoomInfo, # @U
        182 => GetInterest, # Bv
    }

    CLIENT_HEADERS = {
        :public_key => 1,
        :ping => 50,
        :rights => 2,
        :login_ok => 3,
        :credits => 6,
        :greeting => 0,
        :name => 5,
        :club_habbo => 7,
    }

  end

end