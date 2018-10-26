class Song

  attr_reader :title, :artist, :genre, :duo

  def initialize(title, artist, length, genre, duo)
    @title = title
    @artist = artist
    @length = length
    @genre = genre
    @duo = duo
  end

  def length
    minutes = @length/60
    seconds = @length%60

    return "#{minutes}:#{seconds}"
  end

end
