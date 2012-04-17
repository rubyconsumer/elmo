class AddRegionToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :region, :text
  end
end
