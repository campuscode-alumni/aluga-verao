class AddPurposeRefToProperty < ActiveRecord::Migration[5.1]
  def change
    add_reference :properties, :purpose, foreign_key: true
  end
end
