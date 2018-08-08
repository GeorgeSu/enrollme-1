class Request < ActiveRecord::Base
  #belongs_to :user
  belongs_to :team, foreign_key: "source_id"
  
  validates :source_id, numericality: true
  validates :target_id, numericality: true
  validates :team, presence: true
  validate :target_cannot_be_own_team, :new_size_cannot_be_too_big, :target_exists
  
  def target_cannot_be_own_team
    if self.target_id == self.source_id
      errors.add(:target, "Target cannot be own team")
    end
  end
  
  def new_size_cannot_be_too_big
    target = Team.find_by(id: self.target_id)
    source = Team.find_by(id: self.source_id)
    if target.getNumMembers + source.getNumMembers > Option.maximum_team_size
      errors.add(:size, "Target cannot accomodate all members")
    end
  end
  
  def target_exists
    if !Team.find_by(id: self.target_id)
      errors.add(:target, "Target does not exist")
    end
  end

  def target_users_list
      return Array.wrap(Team.find(self.target_id).users)
  end

  def join(source, target)
    #Push all the users from the source onto the target
    source.users.each do |user|
      target.users << user
      target.update_waitlist    
      user.team = target
    end
    #Make sure old requests from the source team are now using the new id
    #But only if there are still valid
    old_requests = Request.where(source_id: source.id)
    old_requests.each do |req|
      if Team.find_by(id: req.source_id).getNumMembers + Team.find_by(id: req.target_id).getNumMembers <= Option.maximum_team_size
        target.requests << req
        req.team = target
        req.save
      else
        req.destroy
      end
    end
    #Make sure old requests to the source team are now using the new id
    #Unless the old target was the current team, then don't do that
    #Also check to make sure old requests to the source team will still be valid
    old1_requests = Request.where(target_id: source.id)
    old1_requests.each do |req|
      if (req.source_id == target.id) || (Team.find_by(id: req.source_id).getNumMembers + Team.find_by(id: target.id).getNumMembers > Option.maximum_team_size)
        target.requests.destroy(req)
      else
        req.target_id = target.id
        req.save
      end
    end
    
    #Delete the old team 
    source.destroy
  end

end