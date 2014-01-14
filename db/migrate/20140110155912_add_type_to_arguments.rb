class AddTypeToArguments < ActiveRecord::Migration
  def change
    add_column :arguments, :titre_graphe, :text
    add_column :arguments, :legende_graphe, :text
  end
end
