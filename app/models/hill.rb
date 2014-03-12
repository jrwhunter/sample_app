require "csv"

class Hill < ActiveRecord::Base

	def self.import(file)
  		CSV.foreach(file.path, headers: true) do |row|
    		Hill.create! row.to_hash
  		end
	end

end
