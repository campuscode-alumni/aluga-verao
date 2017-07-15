class RemovePhotoFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :photo, :string
  end
end
