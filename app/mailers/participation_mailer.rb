class ParticipationMailer < ApplicationMailer
  default from: 'mathieu.liem00@gmail.com'
 
  def event_participation_email(participation)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = participation.user 
    @event = participation.event 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: "Tu viens de t\'inscrire à l\'evenement #{@event.title}") 
  end
end
