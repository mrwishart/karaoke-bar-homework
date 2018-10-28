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

  def receive_money(amount)
    @total_money +=amount
  end

  def pay_money(price)
    @total_money -= price if can_afford?(price)
  end

  def is_favourite?(song)
    return song.title.downcase == @favourite_song.downcase
  end

  def check_song(song)
    return is_favourite?(song) ? "Woo, my favourite!" : "Meh"
  end

  def favourite_in_playlist?(playlist)
    return playlist.reduce(false){ |test, song| test || is_favourite?(song)}
  end

  def check_playlist(playlist)
    return favourite_in_playlist?(playlist) ? "Woo, it's got my favourite song!" : "Meh, whatever"
  end

end
