require_relative('message')

class Room

  attr_reader :name, :capacity, :room_fee, :individual_fee, :remaining_spaces, :reserved

  def initialize(name, capacity, room_fee)
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

  def book_guest(guest)
    # Check if room is reserved
    return @result.room_reserved if @reserved

    # Check if room is full
    return @result.room_full if @remaining_spaces == 0

    # Add guest
    @occupants << guest

    update_remaining_spaces

    return @result.room_booked

  end

  def book_guests(guests, to_reserve=false)
    # Check if room is reserved
    return @result.room_reserved if @reserved

    # Check if room is full
    return @result.room_full if @remaining_spaces < guests.count

    # Add guests
    @occupants.concat(guests)

    update_remaining_spaces

    @reserved = to_reserve

    return @result.room_booked

  end

  def remove_guest(guest)
    #Check if room is empty
    return @result.room_empty if @occupants.empty?

    removed_guest = @occupants.delete(guest)

    return @result.guest_404 if removed_guest.nil?

    update_remaining_spaces

    @reserved = false

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


end
