class Registration < ActiveRecord::Base
  belongs_to :tournaments
  belongs_to :player, :sponsor
  
  #validates :full_name, :email, :telephone, presence: true
  
  def get_paypal(return_path)
    
  end
end

  
