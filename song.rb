class Song

  attr_reader :title, :artist, :genre, :is_duo

  def initialize(title, artist, length, genre, is_duo)
    @title = title
    @artist = artist
    @length = length
    @genre = genre
    @is_duo = is_duo
  end

  def length
    minutes = @length/60
    seconds = @length%60

    return "#{minutes}:#{seconds}"
  end

end
