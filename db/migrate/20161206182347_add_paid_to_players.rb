class AddPaidToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :paid, :boolean
  end
end
