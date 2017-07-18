class AddOwnerReferenceToProperty < ActiveRecord::Migration[5.1]
  def change
    add_reference :properties, :owner, foreign_key: true
  end
end
