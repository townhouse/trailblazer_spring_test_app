require 'reform'
require 'minitest/autorun'

class ReformSpec < MiniTest::Spec
  let (:duran)  { Struct.new(:name).new("Duran Duran") }
  let (:rio)    { Struct.new(:title).new("Rio") }
end

require 'active_record'
class Artist < ActiveRecord::Base
end

class Song < ActiveRecord::Base
  belongs_to :artist
end

class Album < ActiveRecord::Base
  has_many :songs
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "#{Dir.pwd}/database.sqlite3"
)


#Artist.delete_all

class BaseTest < MiniTest::Spec
  class AlbumForm < Reform::Form
    property :title

    property :hit do
      property :title
    end

    collection :songs do
      property :title
    end
  end

  Song   = Struct.new(:title, :length)
  Album  = Struct.new(:title, :hit, :songs, :band)
  Band   = Struct.new(:label)
  Label  = Struct.new(:name)
  Length = Struct.new(:minutes, :seconds)


  let (:hit) { Song.new("Roxanne") }
end

MiniTest::Spec.class_eval do
  module Saveable
    def save
      @saved = true
    end

    def saved?
      @saved
    end
  end
end