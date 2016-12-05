class Photo < ApplicationRecord
	has_one :tournament

  mount_uploader :photoLink, PhotoUploader
end
