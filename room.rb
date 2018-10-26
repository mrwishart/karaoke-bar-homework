class Room

  attr_reader :name, :capacity, :room_fee, :individual_fee

  def initialize(name, capacity, room_fee)
    @name = name
    @capacity = capacity
    @playlist = []
    @occupants = []
    @reserved = false
    @room_fee = room_fee.round(2)
    #Individual booking is 20% extra
    @individual_fee = (1.2*@room_fee/@capacity).round(2)
  end

end
