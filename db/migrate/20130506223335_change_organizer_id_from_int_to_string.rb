class ChangeOrganizerIdFromIntToString < ActiveRecord::Migration
  def change
    change_column :groups, :organizer_id, :string
  end
end
