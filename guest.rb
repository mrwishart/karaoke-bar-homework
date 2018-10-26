class Guest

  attr_reader :name, :age, :favourite_song

  def initialize(name, age, favourite_song)
    @name = name
    @age = age
    @favourite_song = favourite_song
  end

end
