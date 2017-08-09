
class TeamController < ApplicationController
  

  
  before_filter :set_user, :set_team, :except => ['list', 'profile']
  before_filter :set_permissions, :except => ['list', 'profile', 'next_rec', 'prev_rec']
  before_filter :check_approved, :only => ['submit', 'unsubmit', 'edit']
  
  # @@suggested_team = Team.first
  # def self.suggested_team
  #   @@suggested_team
  # end


  def show
    @discussions = Discussion.valid_discs_for(@team)
    if @team.submitted and !(@team.approved)
      @s = Submission.find(@team.submission_id)
      @d1 = Discussion.find(@s.disc1id)
      @d2 = Discussion.find_by_id(@s.disc2id)
      @d3 = Discussion.find_by_id(@s.disc3id)
    end
    render "team"
  end
  
  def submit
    EmailStudents.successfully_submitted_email(@team).deliver_now
    AdminMailer.send_look_at_submission
    
    redirect_to new_submission_path
  end
  
  def unsubmit
    @submission = @team.submission
    @submission.destroy!
    @team.withdraw_submission
    redirect_to team_path(@team.id)
  end
  
  def edit
    @user_to_remove = User.find_by_id(params[:unwanted_user])
    @user_to_remove.leave_team
    notice = ""

    if @user.is_a? Admin and @team.approved
      @team.disapprove
    elsif @team.submitted
      notice = " Your team's submission has been withdrawn."
    end

    @team.withdraw_submission
    return redirect_to without_team_path if @user_to_remove == @user
    return redirect_to team_path(@team.id), notice: "Removed #{@user_to_remove.name} from team." + notice
  end
  
  def list
    sort = 'default'
    @waitlist_filter =['true', 'false']
    @num_members_filter = ['1', '2', '3', '4', '5', '6']
    
    ordering = {:users_count => :desc}
    @teams = Team.order(ordering)
    @suggested_team = get_rec(0)
    @users_pic_arr = @suggested_team.members_pictures
    @users_name_arr = @suggested_team.members_names
=begin
    # The code below is for suggestion
    @recommended_team = Team.find_by_id(3)
    @users_pic_arr = @recommended_team.members_pictures_thumb
=end
  end

  def next_rec
    @suggested_team = get_rec(1)
    @users_pic_arr = @suggested_team.members_pictures
    @users_name_arr = @suggested_team.members_names
    # ajax call to render partial
    render :partial => 'suggestion', :object => @suggested_team and return if request.xhr?
    redirect_to team_list_path
  end
  
  def prev_rec
    @suggested_team = get_rec(-1)
    @users_pic_arr = @suggested_team.members_pictures
    @users_name_arr = @suggested_team.members_names
    # ajax call to render partial
    render :partial => 'suggestion', :object => @suggested_team and return if request.xhr?
    redirect_to team_list_path
  end
  
  def get_rec(direction)
    @user = User.find_by(id: session[:user_id])
    @team = @user.team
    #Get sorted matches, iterate through using pointer, and save pointer
    matches = @team.sortedMatches
    @user[:recommendation_pointer] = (@user[:recommendation_pointer] + direction) % matches.length
    match_team_id = matches[@user[:recommendation_pointer]][0]
    @user.save
    return Team.find_by(id: match_team_id)
  end

  def profile
    @team = Team.find_by_id(params[:id])
    @users_id = @team.users.map{|user| user.id}
    @users_name_arr = @team.members_names
    @users_time_arr = @team.members_time_commitments
    @users_bio_arr = @team.members_bios
    @users_exp_arr = @team.members_experiences
    @users_fb_arr = @team.members_facebooks
    @users_lk_arr =@team.members_linkedins
    @users_email_arr = @team.members_emails
    @users_pic_arr = @team.members_pictures
    @users_major_arr = @team.members_majors
    @users_waitlist_arr = @team.members_waitlisteds
    @users_days_arr = @team.members_schedules
    @users_skills_arr = @team.members_skill_sets
    # @discussions = Discussion.valid_discs_for(@team)
    # if @team.submitted and !(@team.approved)
    #   @s = Submission.find(@team.submission_id)
    #   @d1 = Discussion.find(@s.disc1id)
    #   @d2 = Discussion.find_by_id(@s.disc2id)
    #   @d3 = Discussion.find_by_id(@s.disc3id)
    # end
  end
  private
  
  def set_user
    if session[:is_admin]
      @user = Admin.find(session[:user_id])
    elsif session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to without_team_path, :notice => "Permission denied: you don't have a team" if @user.team.nil?
    else
      redirect_to '/', :notice => "Please log in"
    end
  end

  def set_team
    @team = Team.find_by_id(params[:id])
  end

  def set_permissions
    # checking that the team we are looking for exists and that the user doing the action on the team is either an admin or a student on the same team
    if @team.nil? or (session[:is_admin].nil? and @user.team != @team)
      redirect_to '/', :notice => "Permission denied: no permission"
    end
  end
  
  def check_approved
    redirect_to '/', :notice => "Permission denied: not approved" if @team.approved and !(@user.is_a? Admin)
  end

  def findCompatibleTeams
    @team = Team.find_by_id(params[:id])
    @other_teams = Team.where.not(id: params[:id])
    teamScores = []
    @other_teams.each { |otherTeam| teamScores << [otherTeam.id, @team.getTeamCompatibility(otherTeam)]}
    return teamScores
  end
end