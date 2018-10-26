class Guest

  attr_reader :name, :age, :favourite_song

  def initialize(name, age, favourite_song, total_money)
    @name = name
    @age = age
    @favourite_song = favourite_song
    @total_money = total_money
  end

  def can_afford?(price)
    return @total_money >= price
  end

end
