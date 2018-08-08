class RequestsMailer < ApplicationMailer

    def self.send_notify_emails(user, targets, body)
        targets.each do |target|
            # notify_email(user, target, body).deliver_now
        end
    end
    
    def notify_email(user, target, body)
        @user = user
        @target = target  
        @body = body
        mail(to: @target.email, subject: 'You have a new incoming request')
      end
end
