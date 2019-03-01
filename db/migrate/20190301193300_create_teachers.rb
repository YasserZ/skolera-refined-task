class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :age

      t.timestamps
    end
  end
end
