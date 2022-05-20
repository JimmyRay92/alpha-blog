class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.text :availability
      t.integer :price
      t.integer :lesson_length
      t.text :bio
      t.text :teaching_info
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
