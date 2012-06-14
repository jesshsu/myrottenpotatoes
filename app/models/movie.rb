class Movie < ActiveRecord::Base
  def self.all_ratings
    a = Array.new
    self.select("rating").uniq.each {|e| a.push(e.rating)}
    a.sort.uniq
  end
end
