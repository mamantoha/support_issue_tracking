class TicketMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def new_ticket(ticket)
    @ticket = ticket
    @url_path = "/tickets/#{@ticket.display_id}"
    mail(to: @ticket.email,
         subject: 'Your request has been received',
         template_path: 'ticket_mailer',
         template_name: 'new_ticket')
  end
end
