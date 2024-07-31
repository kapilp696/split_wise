lass CreateAccount < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.boolean :verified

      t.timestamps
    end
  end
end
