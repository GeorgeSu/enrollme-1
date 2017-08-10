require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Team, type: :model do
  describe "a vectors can be extracted from a user" do
    context '2 users' do
      before :each do
        @team1 = Team.all.first
        @team2 = Team.all.last
      end

      # it "returns a its feature vectors" do
      #   expect(@team1.getTeamSkillsVector).to eq(Vector[1,1,1,1,1])
      #   expect(@team1.getTeamScheduleVector).to eq(Vector[1,1,1,1,1,1,1])
      # end

      # it "returns compatibility score with other team/teams" do
      #   expect(@team1.getTeamCompatibility(@team2)).to eq(0.592554128318002)
      #   expect(@team1.findCompatibleTeams).to include([5, 0.6193111704778094])
      # end
    end
  end
end
