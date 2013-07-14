require_relative '../../db/config'


class Legislator < ActiveRecord::Base
  before_save :format_phone_numbers

  def format_phone_numbers
    phone.gsub!('-','')
  end

  def self.senators_and_reps_by_last_name(state)
    results = Legislator.where(state: state)
    puts "Senators:"
    senators = results.where(title: "Sen").order('lastname')
    senators.each { |senator| puts "   #{senator.firstname} #{senator.lastname} (#{senator.party})" }
    puts "Representatives:"
    representatives = results.where(title: "Rep").order('lastname')
    representatives.each { |rep| puts "   #{rep.firstname} #{rep.lastname} (#{rep.party})" }
  end

  def self.number_and_percent_sens_reps_by_gender(gender)
    total = Legislator.where(in_office: '1') #1 means active memebers
    gender_results = Legislator.where(gender: gender, in_office: '1')
  
    gender_senators = gender_results.where(title: "Sen").size
    all_senators = total.where(title: "Sen").size
    puts "#{gender == 'M' ? 'Male' : 'Female'} Senators: #{gender_senators.to_i} (#{(gender_senators.to_f/all_senators.to_f*100.0).floor}%)"
  
    gender_reps = gender_results.where(title: "Rep").size
    all_reps = total.where(title: "Rep").size
    puts "#{gender == 'M' ? 'Male' : 'Female'} Representatives: #{gender_reps.to_i} (#{(gender_reps.to_f/all_reps.to_f*100.0).floor}%)"
  end

  def self.most_congress_people_by_state
    all_active_reps = Legislator.where(title: "Rep", in_office: '1')
    group_state_reps = all_active_reps.group(:state).count
    group_state_reps.each { |state,count| puts "#{state}: 2 Senators, #{count} Representatives" }
  end

  def self.total_senators_reps
    all = Legislator.all
    all_reps = Legislator.where(title: "Rep")
    all_sens = Legislator.where(title: "Sen")
    
    puts "Senators #{all_sens.count}"
    puts "Representatives #{all_reps.count}"
  end

end

# Legislator.senators_and_reps_by_last_name("CA")

# Legislator.number_and_percent_sens_reps_by_gender('M')

# Legislator.most_congress_people_by_state

# Legislator.total_senators_reps

# Legislator.where(in_office: "0").each do |person|
#   person.destroy
# end

# Legislator.total_senators_reps

