require "pry"

class User
    attr_accessor :email, :age
  
    @@all_users = []
  
    def initialize(email, age)
      @email = email
      @age = age
      @@all_users << self
    end
  
    def self.all
      @@all_users
    end
  end
  
  binding.pry
  puts 'julie = User.new("coucou")'
  