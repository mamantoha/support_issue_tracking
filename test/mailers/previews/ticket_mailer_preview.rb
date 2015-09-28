# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview
  def new_ticket
    TicketMailer.new_ticket(Ticket.first)
  end
end
