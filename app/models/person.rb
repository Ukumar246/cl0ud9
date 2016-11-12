class Person < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         # Might need these later
         # ,:confirmable, :lockable

  has_many :players

  #Rabachi: for TOS agreement checking
  validates :terms_of_service, acceptance: true
end
