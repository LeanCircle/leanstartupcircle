class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :meeting_at
      t.string :location_name
      t.string :location_address
      t.references :group

      t.timestamps
    end
    add_index :events, :group_id
  end
end
