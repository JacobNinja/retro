Sequel.migration do
  change do
    create_table :room_types do
      primary_key :id
      String :name
      Integer :max_guests
      String :heightmap
      String :ccts
      String :model
      Integer :guest
      Integer :start_x
      Integer :start_y
      Integer :start_z
      Integer :user_type
      Float :max_ascend
      Float :max_descend
    end
  end
end