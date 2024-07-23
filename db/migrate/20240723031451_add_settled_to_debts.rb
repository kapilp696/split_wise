class AddSettledToDebts < ActiveRecord::Migration[7.1]
  def change
    add_column :debts, :settled, :boolean, default: false
  end
end
