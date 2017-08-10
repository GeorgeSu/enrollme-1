class SubmissionsController < ApplicationController
    
    def new
        @submission = Submission.new
        render 'new'
    end
    
    def create
        @user = User.find_by_id(session[:user_id])
        @team = Team.find_by_id(@user.team.id)
        
        d1 = submission_params[:disc1id]
        d2 = submission_params[:disc2id]
        d3 = submission_params[:disc3id]
        
        if Discussion.valid_discs_for(@team).count == 1
            @submission = Submission.new(:disc1id => d1)
        elsif Discussion.valid_discs_for(@team).count == 2
            return redirect_to new_submission_path, notice: "Please choose 2 different discussions." if [d1, d2, d3].uniq.length == 1
            @submission = Submission.new(:disc1id => d1, :disc2id => d2)
        else
            return redirect_to new_submission_path, notice: "Please choose 3 different discussions." if [d1, d2, d3].uniq.length == 2 or [d1, d2, d3].uniq.length == 1
            @submission = Submission.new(submission_params)
        end
        
        @submission.team = @team
        
        @submission.save!
        @team.add_submission(@submission.id)
        
        
        EmailStudents.successfully_submitted_email(@team).deliver_now
        AdminMailer.send_look_at_submission
        
        flash[:success] = "Thanks for submitting your team for enrollment"
        return redirect_to team_path(@team)
    end
    
    def destroy
    end

    private
        def submission_params
            params.require(:submission).permit(:disc1id, :disc2id, :disc3id)
        end
end