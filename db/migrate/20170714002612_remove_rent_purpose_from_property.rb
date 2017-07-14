class RemoveRentPurposeFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :rent_purpose, :string
  end
end
