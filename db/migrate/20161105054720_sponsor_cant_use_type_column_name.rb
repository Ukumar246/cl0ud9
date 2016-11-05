class SponsorCantUseTypeColumnName < ActiveRecord::Migration[5.0]
  def change
    change_table :sponsors do |s|
      s.rename :type, :sponsorshipType
    end
  end
end
