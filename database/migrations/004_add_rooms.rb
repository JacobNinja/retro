Sequel.migration do

  change do

    create_table :rooms do
      primary_key :id
      String :name
      String :description
      Integer :owner_id
      Integer :category_id
      Integer :type_id
      String :status
    end

  end

end