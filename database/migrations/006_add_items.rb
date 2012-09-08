Sequel.migration do

  change do

    create_table :items do
      primary_key :id
      Integer :furni_definition_id
      Integer :user_id
      Integer :room_id
      String :wall_location
      Integer :x
      Integer :y
    end

  end

end