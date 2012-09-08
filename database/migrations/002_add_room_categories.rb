Sequel.migration do

  change do

    create_table(:room_categories) do
      primary_key :id
      Integer :type
      String :name
      Integer :parent
    end

  end

end