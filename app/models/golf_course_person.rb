class GolfCoursePerson < ApplicationRecord
  belongs_to :person
  belongs_to :golf_course

  validates :person_id, presence: true
  validates :golf_course_id, presence: true

end
