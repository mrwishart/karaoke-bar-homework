require_relative('message')

class Room

  attr_reader :name, :capacity, :room_fee, :individual_fee, :remaining_spaces, :reserved, :till_amount

  def initialize(name, capacity, room_fee, till_amount=100)
    @name = name
    @capacity = capacity
    #Room is initially empty
    @remaining_spaces = capacity
    @playlist = []
    @occupants = []
    @reserved = false
    @room_fee = room_fee.round(2)
    #Individual booking is 20% extra
    @individual_fee = (1.2*@room_fee/@capacity).round(2)
    #Unless otherwise stated, float is 100
    @till_amount = till_amount
    @result = Message.new
  end

  def number_of_songs
    return @playlist.count
  end

  def update_remaining_spaces
    @remaining_spaces = @capacity - @occupants.count
  end

  def occupants_names
    return @occupants.map{ |guest| guest.name}
  end

  def list_occupants
    return @result.list_occupants(occupants_names)
  end

  def add_to_till(amount)
    @till_amount += amount
  end

  def book_guest(guest)
    # Check if room is reserved
    return @result.room_reserved if @reserved

    # Check if room is full
    return @result.room_full if @remaining_spaces == 0

    return @result.customer_cant_afford if !guest.can_afford?(@individual_fee)

    # Add guest
    @occupants << guest
    # Take money from customer (individual bookings paid upfront)
    guest.pay_money(@individual_fee)
    # Put money in till
    add_to_till(@individual_fee)

    return booking_successful

  end

  def book_guests(guests, to_reserve=false)
    # Check if room is reserved
    return @result.room_reserved if @reserved

    # Check if room is full
    return @result.room_full if @remaining_spaces < guests.count

    #Only allow reservation change if room is currently empty
    @reserved = to_reserve if @occupants.empty?

    # Add guests
    @occupants.concat(guests)

    return booking_successful

  end

  def remove_guest(guest)
    #Check if room is empty
    return @result.room_empty if @occupants.empty?

    return @result.group_cancel if @reserved

    removed_guest = @occupants.delete(guest)

    return @result.guest_404 if removed_guest.nil?

    return remove_successful

  end

  def remove_guests(guests)
    #Check if room is empty
    return @result.room_empty if @occupants.empty?

    #If reserved, clear entire booking
    return empty_room if @reserved

    #Remove each guest from room
    removed_guests = guests.map{ |guest| @occupants.delete(guest) }

    removed_guests.compact!

    return @result.guest_404 if removed_guests.empty?

    return remove_successful

  end

  def empty_room
    @occupants = []
    update_remaining_spaces
    unreserve_room
    return @result.room_emptied
  end

  def booking_successful
    update_remaining_spaces
    return @result.room_booked
  end

  def remove_successful
    update_remaining_spaces
    unreserve_room if @reserved
    return @result.guest_unbooked
  end

  def add_song(song)
    return if @playlist.include?(song)
    @playlist << song
  end

  def add_songs(songs)
    @playlist.concat(songs)
    #Remove duplicate songs
    @playlist.uniq!
  end

  def remove_song(song)
    @playlist.delete(song)
  end

  def find_song(song)
    return @playlist.find {|track| track == song}
  end

  def unreserve_room
    @reserved = false
  end

end
