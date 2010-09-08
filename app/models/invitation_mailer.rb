class InvitationMailer < ActionMailer::Base
   def invitation(invitation, sent_at = Time.now)
        recipients invitation.email
        from invitation.user.email
        subject "Join my crew?"
        @invitation=invitation
   end


end
