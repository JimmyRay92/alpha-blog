class CreateTeachersStyles < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers_styles do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :style, null: false, foreign_key: true

      t.timestamps
    end
  end
end
