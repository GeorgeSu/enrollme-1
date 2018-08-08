
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admins = [
    { :name => "EnrollMe", :email => "enrollmeberkeley@gmail.com", :superadmin => true},
    { :name => "Michael-David Sasson", :email => "sasson@berkeley.edu", :superadmin => false},
    { :name => "George Su", :email => "georgesu1074@gmail.com", :superadmin => false},
    { :name => "Derek Hsiao", :email => "hsiaoderek@berkeley.edu", :superadmin => false},
    { :name => "Karl Hayek", :email => "karlos9009@gmail.com", :superadmin => false},
      { :name => "Ken Chiu", :email => "kenchiu@berkeley.edu", :superadmin => false},
      { :name => "Hadi Zhang", :email => "hadizhang@gmail.com", :superadmin => true}
]

Admin.delete_all
admins.each do |a|
  Admin.create!(a)
end


discussions = [
  { :number => 10001, :time => "2:00pm-3:00pm", :capacity => 25, :submission_id => 1, :day => "Monday"},
  { :number => 10002, :time => "5:00pm-6:00pm", :capacity => 25, :submission_id => 2, :day => "Wednesday"},
  { :number => 10003, :time => "3:00pm-4:00pm", :capacity => 30, :submission_id => 3, :day => "Monday"}
]

Discussion.delete_all
discussions.each do |d|
  Discussion.create!(d)
end


Option.delete_all
Option.create!(
  :minimum_team_size => 5,  
  :maximum_team_size => 6
  )
  
User.delete_all
Team.delete_all


users = [
  {:name => "Gore Su", :email => "gs@gmail.com", :major => 'DECLARED CS/EECS Major', :facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com",:waitlisted => true, :sid => 123456, :time_commitment=>20, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1),:bio=>"I Love Coding All Day And Night",:experience=>"I worked in yelp"},
  {:name => "Ha Z", :email => "hz@gmail.com", :major => 'DECLARED CS/EECS Major', :facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com",:waitlisted => true, :sid => 1234567, :time_commitment=> 30, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 0, :team_management => 1, :frontend => 0, :ui_design => 1),:bio=>"I Love Coding All Day And Night",:experience=>"I worked in yelp"},
  {:name => "Dere Hsiao", :email => "dh@gmail.com", :major => 'DECLARED CS/EECS Major', :facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com",:waitlisted => true, :sid => 123453, :time_commitment=> 40, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1),:bio=>"I Love Coding All Day And Night",:experience=>"I worked in yelp"},
  {:name => "Ka Chiu", :email => "kc@gmail.com", :major => 'DECLARED CS/EECS Major', :facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com",:waitlisted => true, :sid => 123454, :time_commitment=> 50, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 0),:bio=>"I Love Coding All Day And Night",:experience=>"I worked in uber"},
  {:name => "Bran J", :email => "bj@gmail.com", :major => 'DECLARED CS/EECS Major',:facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com", :waitlisted => true, :sid => 153456, :time_commitment=>10, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 0, :ui_design => 0),:bio=>"I Love Coding All Day And Night",:experience=>"I worked in uber"},
  {:name => "Kal Hek", :email => "kh@gmail.com", :major => 'DECLARED CS/EECS Major',:facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com", :waitlisted => true, :sid => 123756, :time_commitment=>15, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 0, :team_management => 0, :frontend => 0, :ui_design => 1),:bio=>"I Love CS169",:experience=>"I worked in uber"},
  {:name => "Carina Boo", :email => "cb@gmail.com", :major => 'DECLARED CS/EECS Major',:facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com", :waitlisted => true, :sid => 1238556, :time_commitment=>20, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1),:bio=>"I Love CS169 and chickends and rabbit and puppies.",:experience=>"I worked in goggle"},
  {:name => "Oski Bear", :email => "ob@gmail.com", :major => 'DECLARED CS/EECS Major', :facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com",:waitlisted => true, :sid => 123446, :time_commitment=>100, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1),:bio=>"I Love CS169",:experience=>"I worked in airbnb"},
  {:name => "Eric Smith", :email => "aladdin@gmail.com", :major => 'DECLARED CS/EECS Major', :facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com", :waitlisted => true, :sid => 19356, :time_commitment=>55, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 1, :team_management => 1, :frontend => 0, :ui_design => 1),:bio=>"I Love CS169",:experience=>"I worked in airbnb"},
  {:name => "Jon X", :email => "skorpionstpe@gmail.com", :major => 'DECLARED CS/EECS Major', :facebook =>"http://www.facebook.com" ,:linkedin =>"http://www.linkedin.com",:waitlisted => false, :sid => 9344456, :time_commitment=>55, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1),:bio=>"I Love CS169",:experience=>"I worked in airbnb"}
]

team1 = Team.new(:passcode => Team.generate_hash, :approved => false, :submitted => false)
team2 = Team.new(:passcode => Team.generate_hash, :approved => false, :submitted => false)
team3 = Team.new(:passcode => Team.generate_hash, :approved => false, :submitted => false)

sample_schedule1 = {:monday => 0, :tuesday => 0, :wednesday =>0, :thursday => 0, :friday => 0, :saturday => 0, :sunday => 0}
sample_schedule2 = {:monday => 1, :tuesday => 1, :wednesday =>1, :thursday => 1, :friday => 1, :saturday => 1, :sunday => 1}
sample_schedule3 = {:monday => 1, :tuesday => 0, :wednesday =>1, :thursday => 0, :friday => 1, :saturday => 0, :sunday => 1}

sample_skillset1 = {:ruby_on_rails => 0, :other_backend => 0, :frontend => 0, :ui_design => 0, :team_management => 0}
sample_skillset2 = {:ruby_on_rails => 1, :other_backend => 1, :frontend => 1, :ui_design => 1, :team_management => 1}
sample_skillset3 = {:ruby_on_rails => 0, :other_backend => 1, :frontend => 0, :ui_design => 1, :team_management => 0}

for i in 0...users.length
  current_user = User.create!(users[i])
  if i % 3 == 0
    current_user.schedule = Schedule.create!(sample_schedule1)
    current_user.skill_set = SkillSet.create!(sample_skillset1)
  elsif i% 3 == 1
    current_user.schedule = Schedule.create!(sample_schedule2)
    current_user.skill_set = SkillSet.create!(sample_skillset2)
  else
    current_user.schedule = Schedule.create!(sample_schedule3)
    current_user.skill_set = SkillSet.create!(sample_skillset3)
  end
  if i < 2
    team1.users << current_user
    team1.update_waitlist
    current_user.team = team1
  elsif i < 5
    team2.users << current_user
    team2.update_waitlist
    current_user.team = team2
  elsif i < 10
    team3.users << current_user
    team3.update_waitlist
    current_user.team = team3
  elsif i < 14
    team4.users << current_user
    team4.update_waitlist
    current_user.team = team4
  elsif i < 19
    team5.users << current_user
    team5.update_waitlist
    current_user.team = team5
  elsif i < 22
    team6.users << current_user
    team6.update_waitlist
    current_user.team = team6
  elsif i < 25
    team7.users << current_user
    team7.update_waitlist
    current_user.team = team7
  elsif i < 28
    team8.users << current_user
    team8.update_waitlist
    current_user.team = team8
  elsif i < 31
    team9.users << current_user
    team9.update_waitlist
    current_user.team = team9
  end
end
