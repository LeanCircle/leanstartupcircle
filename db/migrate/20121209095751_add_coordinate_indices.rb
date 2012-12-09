class AddCoordinateIndices < ActiveRecord::Migration
  def change
    add_index :meetups, [:latitude, :longitude]
    add_index :users, [:latitude, :longitude]
  end

end
