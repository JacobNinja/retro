Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      String :name
      String :password
      String :figure
      String :sex
      String :mission
    end
  end
end