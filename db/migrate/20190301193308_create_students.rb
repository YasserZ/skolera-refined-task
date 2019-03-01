class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :age
      t.integer :grade

      t.timestamps
    end
  end
end
