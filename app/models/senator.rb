require_relative 'legislator'

class Senator < Legislator
  def self.all
    Legislator.where(title:"Sen")
  end

  def self.all_with_twitter
    Legislator.where(title:"Sen").where("twitter_id != ''")
  end
end


