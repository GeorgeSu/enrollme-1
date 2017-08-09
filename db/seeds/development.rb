# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admins = [
    { :name => "Karl Hayek", :email => "kch05@berkeley.edu", :superadmin => true},
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

# Below is all of my Test Seeds - George

User.delete_all
Team.delete_all

users = [
  {:name => "George Su", :email => "gs@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 123456, :time_commitment=>20, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1)},
  {:name => "Hadi Zhang", :email => "hz@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 1234567, :time_commitment=> 30, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 0, :team_management => 1, :frontend => 0, :ui_design => 1)},
  {:name => "Derek Hsiao", :email => "dh@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 123453, :time_commitment=> 40, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1)},
  {:name => "Ken Chiu", :email => "kc@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 123454, :time_commitment=> 50, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 0)},
  {:name => "Brandon Jabr", :email => "bj@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 153456, :time_commitment=>10, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 0, :ui_design => 0)},
  {:name => "Karl Hayek", :email => "kh@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 123756, :time_commitment=>15, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 0, :team_management => 0, :frontend => 0, :ui_design => 1)},
  {:name => "Carina Boo", :email => "cb@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 1238556, :time_commitment=>20, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1)},
  {:name => "Oski Bear", :email => "ob@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 123446, :time_commitment=>100, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1)},
  {:name => "Aladdin", :email => "aladdin@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => true, :sid => 19356, :time_commitment=>55, :skill_set => SkillSet.create(:ruby_on_rails => 0, :other_backend => 1, :team_management => 1, :frontend => 0, :ui_design => 1)},
  {:name => "Kalord", :email => "karlhayek97@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => false, :sid => 9344456, :time_commitment=>55, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1)},
  {:name => "Kalord", :email => "skorpionstpe@gmail.com", :major => 'DECLARED CS/EECS Major', :waitlisted => false, :sid => 94456, :time_commitment=>55, :skill_set => SkillSet.create(:ruby_on_rails => 1, :other_backend => 1, :team_management => 1, :frontend => 1, :ui_design => 1)}
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
  else
    team3.users << current_user
    team3.update_waitlist
    current_user.team = team3
  end
end


