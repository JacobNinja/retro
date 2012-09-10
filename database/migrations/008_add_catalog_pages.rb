Sequel.migration do
  change do

    create_table :catalog_pages do
      primary_key :id
      String :name
      String :visible_name
      Integer :order
      String :layout
      String :image_title
      String :side_image
      String :description
      String :label
      String :additional
      Integer :staff_only
    end

  end
end