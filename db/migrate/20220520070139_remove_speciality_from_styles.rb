class RemoveSpecialityFromStyles < ActiveRecord::Migration[7.0]
  def change
    remove_column :styles, :speciality, :boolean
  end
end
