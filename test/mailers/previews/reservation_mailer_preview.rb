# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def booking_email
    ReservationMailer.booking_email(Reservation.first.user, Reservation.first.listing.user, Reservation.first.id)   
  end
end
