module Retro
  module Handlers

    def self.server_headers
      {
          2 => RoomDirectory, # @B
          4 => Login, # @D
          5 => CheckVersion, # @E
          6 => Shockwave, # @F
          7 => UserDetails, # @G
          8 => Credits, # @H
          12 => MessengerInit, # @L
          16 => SearchRooms, # @P
          18 => FavoriteRooms, # @R
          21 => RoomInfo, # @U
          26 => ClubHabbo, # @Z
          52 => Chat, # @t
          55 => Shout, # @w
          57 => TryFlat, # @y
          59 => GotoFlat, # @{
          60 => Heightmap, # @|
          61 => Users, # @}
          62 => Objects, # @~
          63 => Items, # @\x7F
          64 => GStat, # A@
          65 => Hand, # AA
          67 => Pickup, # AC
          73 => MoveStuff, # AI
          75 => Move, # AK
          79 => LookTo, # AO
          88 => Stop, # AX
          90 => PlaceStuff, # AZ
          93 => Dance, # A]
          94 => Wave, # A^
          100 => CatalogPurchase, # Ad
          101 => CatalogPages, # Ae
          102 => CatalogPageInfo, # Af
          115 => GoAway, # As
          126 => RoomAd, # A~
          150 => Navigate, # BV
          151 => UserFlatCats, # BW
          157 => Badges, # B]
          182 => GetInterest, # Bv
          202 => GenerateKey, # CJ
      }
    end

    def self.client_headers
      {
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

end