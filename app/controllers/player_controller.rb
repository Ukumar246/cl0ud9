class PlayerController < ApplicationController
  def profiles
    @people = Person.order(:fName).first(10)

	@person_id = params[:id].to_i
	@global = @people[@person_id]
	puts "Acessing Page: #@person_id"
    # @people.each do |aPerson|
    #   puts aPerson.inspect
    #   puts "\n"
   	#end

  end
end
