class PlayerController < ApplicationController
  def profiles
    @people = Person.order(:fName).first(10)
    @global = @people[3]

    @people.each do |aPerson|
      puts aPerson.inspect
      puts "\n"
    end

  end
end
