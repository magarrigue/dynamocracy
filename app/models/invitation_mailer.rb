class InvitationMailer < ActionMailer::Base
   def invitation(invitation, sent_at = Time.now)
        recipients invitation.email
        from "Dynamocracy.com<#{invitation}>"
        subject "Bienvenue !"
        @invitation=invitation
   end


end
