class Typeofdebate < ActiveRecord::Migration
  
    def change
      rename_column :debates, :type, :type_of_debate
    end

end
