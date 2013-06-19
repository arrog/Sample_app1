class AddPositionToArguments < ActiveRecord::Migration
  def change
    add_column :arguments, :position, :integer
  end
end
