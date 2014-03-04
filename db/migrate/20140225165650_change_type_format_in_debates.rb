class ChangeTypeFormatInDebates < ActiveRecord::Migration
  def up
    change_column :debates, :type_of_debate, :integer
   end

   def down
    change_column :debates, :type_of_debate, :string
   end
end
