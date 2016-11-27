

json.array! (listing.reservations) do |reservation|
  json.extract! reservation, :id
  json.start reservation.check_in_date
  json.end reservation.check_out_date
  json.url listing_reservation_url(listing, reservation, format: :html)
end