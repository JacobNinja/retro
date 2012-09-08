Sequel.migration do

  change do

    create_table :furni_definitions do
      primary_key :id
      String :sprite
      String :flags, default: ''
      Integer :width
      Integer :length
      Float :height
      String :col
      Integer :var_type
      Float :action_height
      Integer :can_trade
      Integer :public
      String :hand_type
    end

  end

end