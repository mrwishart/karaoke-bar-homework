require_relative('message')

class Room

  attr_reader :name, :capacity, :room_fee, :individual_fee, :remaining_spaces, :reserved, :till_amount, :current_tab

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
    @current_tab = 0
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

    return process_single_guest(guest)

  end

  def process_single_guest(guest)
    # Add guest
    @occupants << guest
    # Take money from customer (individual bookings paid upfront)
    guest.pay_money(@individual_fee)
    # Put money in till
    add_to_till(@individual_fee)

    return booking_successful(guest)
  end

  def book_guests(guests, to_reserve=false)
    # Check if room is reserved
    return @result.room_reserved if @reserved

    # Check if room is full
    return @result.room_full if @remaining_spaces < guests.count

    return (to_reserve ? group_booking(guests) :  multi_individual(guests))
    
  end

  def add_multiple_guests(guests)
    # Add guests
    @occupants.concat(guests)

    return booking_successful(guests)
  end

  def multi_individual(guests)
    return @result.customer_cant_afford if !check_group_of_guests(guests)

    guests.each{|guest| process_single_guest(guest)}

    return booking_successful(guests)

  end

  def group_booking(guests)
    return @result.group_booking_fail if !@occupants.empty?

    open_group_tab
    @reserved = true

    return add_multiple_guests(guests)
  end

  # Tests whether all guests can afford the room's individual fee
  def check_group_of_guests(guests)
    return guests.reduce(true) {|test, guest| test && guest.can_afford?(@individual_fee)}
  end

  def remove_guest(guest)
    #Check if room is empty
    return @result.room_empty if @occupants.empty?
    # Can't remove individual guests from group booking
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

  def open_group_tab
    @current_tab += @room_fee
  end

  def empty_room
    @occupants = []
    update_remaining_spaces
    unreserve_room
    return @result.room_emptied
  end

  def booking_successful(guest)
    update_remaining_spaces
    return @result.room_booked(guest)
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
