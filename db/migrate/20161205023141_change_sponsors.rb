class ChangeSponsors < ActiveRecord::Migration[5.0]
  def change
    remove_column :sponsors, :sponsorshipType, :string

    add_reference :sponsors, :sponsorship, index: true
  end
end
