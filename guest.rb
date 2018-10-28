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

  def pay_money(price)
    @total_money -= price if can_afford?(price)
  end

end
