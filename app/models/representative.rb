require_relative 'legislator'

class Representative < Legislator
  def self.all
    Legislator.where(title:"Rep")
  end


  def self.all_with_twitter
    Legislator.where(title:"Rep").where("twitter_id != ''")
    # Legislator.where(title:"Rep", :twitter_id != nil)
  end
end
