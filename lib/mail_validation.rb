module MailValidation


  def domain
    ENV['ONLY_DOMAIN']
  end

   def email_is_in_domain?
    errors.add_to_base "You must provide an email in the #{domain.downcase} domain (xxxx@#{domain.downcase})" unless email.split('@')[1].downcase == domain.downcase
    errors.add_to_base "trigram email please..." unless email.split('@')[0].length == 3 || domain.downcase != 'octo.com'
  end
  
  def domain_restriction?
    !domain.nil?
  end

end

