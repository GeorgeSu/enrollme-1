class AdminsController < ApplicationController
  
  skip_before_filter :authenticate, :only => ['new', 'create']
  before_filter :validate_admin, :set_admin, :except => ['new', 'create']
  
  def new
    @admin = Admin.new
    render 'new'
  end
  
  def create
    @admin = Admin.new(admin_params)
    @admin.superadmin = false
    if session[:is_admin] == true and @admin.save
      AdminMailer.invite_new_admin(@admin).deliver_now
      redirect_to admins_path, :success => "You created admin " + admin_params["name"] + " successfully!"
    else
      render 'new', :error => "Form is invalid"
    end
  end

  def update
    @admin.update_attributes!(admin_params)
    return redirect_to admins_path
  end

  def index
    status = params[:status] || session[:status] ||= "All"
    @status = session[:status] = params[:status] = status

    @teams_li = Team.filter_by(status)                                             

    render 'index'
  end
  
  def approve
    @team = Team.find_by_id(params[:team_id])
    @team.approved = true
    @team.save!
    
    AdminMailer.send_approved_email(@team).deliver_now
    
    if !(params[:disc].nil?)
      Team.find_by_id(params[:team_id]).approve_with_discussion(params[:disc])
    end
    redirect_to admins_path
  end
  
  def disapprove
    @team = Team.find_by_id(params[:team_id])
    @team.approved = false
    @team.save!
    
    AdminMailer.send_disapproved_email(@team).deliver_now
    
    Team.find_by_id(params[:team_id]).disapprove
    redirect_to admins_path
  end

  def team_list_email
    AdminMailer.team_list_email(@admin, params[:status] || "All").deliver_later
    
    flash[:success] = "Email successfully sent to " + @admin.email

    redirect_to admins_path
  end
  
  def superadmin
    render "super"
  end
  
  def reset_semester
    render "reset"
  end
  
  def reset_database
    @reset_password = params[:reset_password]
    if @reset_password == ENV["ADMIN_DELETE_DATA_PASSWORD"]
      AdminMailer.all_data(@admin).deliver_now if not Rails.env.test?
      User.delete_all
      Team.delete_all
      Submission.delete_all
      Discussion.delete_all
      flash[:success] = "All data reset. Good luck with the new semester!"
      redirect_to "/"
    else
      flash[:error] = "Incorrect password"
      redirect_to reset_semester_path
    end
  end
      
  def transfer
    if @admin.superadmin == true and params[:transfer_admin] != nil
      other_admin = Admin.find(params[:transfer_admin])
      @admin.superadmin = false
      other_admin.superadmin = true
      @admin.save!
      other_admin.save!
      flash[:success] = "Successfully transferred superadmin powers."
    elsif @admin.superadmin == true and params[:transfer_admin] === nil
      flash[:error] = "No admin selected for transfer."
    else
      flash[:error] = "You don't have permission to do that."
    end
    redirect_to superadmin_path
  end
  
  def delete
    if @admin.superadmin == true
      c = 0
      for a in Admin.all
        if params.has_key? "delete_#{a.name}"
          a.destroy!
          c += 1
        end
      end
      
      if c == 1
        flash[:success] = "#{c} admin successfully deleted."
      else
        flash[:success] = "#{c} admins successfully deleted."
      end
    else
      flash[:error] = "You do not have sufficient permissions to do that."
    end
    redirect_to superadmin_path
  end
  
  def destroy
    if @admin.superadmin == false
      @admin.destroy!
      flash[:success] = "You have successfully deleted your admin account."
    else
      flash[:alert] = "Please give someone else superadmin powers before deleting yourself."
    end
    redirect_to '/'
  end

  
  def email_team
    # render partial to send email to the members of a team
    @team_id = params[:team_id]
    @members = users = Team.find(@team_id).users.collect(&:email).join(",")

    # ajax call to render partial
    render :partial => 'email_team', :object => @team_id, :object => @members and return if request.xhr?                                                         
    
    # calls admins#index
    redirect_to admins_path
  end


  def send_email_team
    # get the form parameters 
    @team_id = params[:team_id]
    @members = users = Team.find(@team_id).users.collect(&:email).join(",")
    
    email = params.require(:email).permit(:subject, :content)

    if (email["subject"].length == 0 || email["content"].length == 0)
      flash[:error] = "Error: Please fill both of the email's subject and content fields"
      redirect_to admins_path and return
    end

    AdminMailer.send_email_to_team(@team_id, @members, email).deliver_now
    flash[:success] = "Email successfully sent to team " + @team_id + " (" + @members + ")"
    redirect_to admins_path
  end



  private

  def validate_admin
    if !(session[:is_admin])
      flash[:error] = "Permission denied"
      redirect_to '/'
    end
  end

  def set_admin
    @admin = Admin.find_by_id session[:user_id]
  end
  
  def admin_params
    params.require(:admin).permit(:name, :email)
  end  
  
  def admin_tutorial
    render 'admin_tutorial'
  end


end
