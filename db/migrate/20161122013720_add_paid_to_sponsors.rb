class AddPaidToSponsors < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :paid, :boolean
  end
end
