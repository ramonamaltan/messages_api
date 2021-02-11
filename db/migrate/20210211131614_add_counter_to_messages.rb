class AddCounterToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :counter, :integer
  end
end
