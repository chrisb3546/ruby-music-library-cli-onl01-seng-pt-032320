require "pry"
class Song
    attr_accessor :name
    attr_reader :artist, :genre
   
    

    @@all = []
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        # @@all << self
        self.genre = genre if genre
    end

    def self.all 
       @@all 
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
       song = self.new(name)
       song.save
        song
    end

    def  self.find_by_name(name)
        all.find {|song|song.name == name}
        # binding.pry
    end 

    def self.find_or_create_by_name(name)
        # binding.pry
       self.find_by_name(name) || self.create(name)
        # self.name
       
    end 


     def artist=(artist)
         
        if !artist.songs.include?(self)
            artist.add_song(self)
           
         end
         @artist = artist
     end

     def  genre=(genre)
      if !genre.songs.include?(self)
          genre.add_song(self)
      end
        @genre = genre
    end 

    def self.new_from_filename(filename)
        file = filename.split(" - ")
        song = self.new(file[1])
        artist_name = file[0]
        genrefile = file[2].split(".")
        genre_name = genrefile[0]
        song.artist_name = artist_name
        song.genre_name = genre_name
        song
        
    end 

    def artist_name=(artist_name)
    self.artist = Artist.find_or_create_by_name(artist_name)
    artist.add_song(self)
    end

    def genre_name=(genre_name)
        self.genre = Genre.find_or_create_by_name(genre_name)
        genre.add_song(self)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
        
    end
        
     
        
            
          
      
    
end
