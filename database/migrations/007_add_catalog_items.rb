Sequel.migration do
  change do

    create_table :catalog_items do
      primary_key :id
      Integer :furni_definition_id
      Integer :catalog_page_id
      Integer :cost
      String :purchase_code
    end

  end
end