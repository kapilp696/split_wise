class CreateDebts < ActiveRecord::Migration[7.1]
  def change
    create_table :debts do |t|
      t.decimal :amount, default: 0.0
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.boolean :settled, default: false
      t.references :group, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :debts, :users, column: :from_user_id
    add_foreign_key :debts, :users, column: :to_user_id
  end
end
