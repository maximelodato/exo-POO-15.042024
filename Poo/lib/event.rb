require "pry"
require "time"

class Event
  attr_accessor :start_date, :duration, :title, :attendees

  @@all_events = []

  def initialize(start_date, duration = 0, title = "", attendees = [])
    @start_date = parse_time(start_date)
    @duration = duration
    @title = title
    @attendees = attendees
    @@all_events << self
  end

  def self.all
    @@all_events
  end

  def postpone_24h
    @start_date += 24 * 60 * 60 
  end

  def end_date
    @start_date + (@duration * 60) # Ajoute la durée en minutes à la start_date
  end

  def is_past?
    Time.now > end_date
  end

  def is_future?
    !is_past?
  end

  def is_soon?
    start_date - Time.now < 30 * 60 # Vérifie si la différence est inférieure à 30 minutes en secondes
  end

  def to_s
    "Titre : #{@title}\nDate de début : #{@start_date}\nDurée : #{@duration} minutes\nInvités : #{@attendees}"
  end

  private

  def parse_time(time)
    return Time.strptime(time, "%Y-%m-%d %H:%M") if time.is_a?(String)
    time
  end
end

class EventCreator
    def initialize
      create_event
    end
  
    def create_event
      puts "Salut, tu veux créer un événement ? Cool !"
      puts "Commençons. Quel est le nom de l'événement ?"
      title = gets.chomp
  
      puts "Super. Quand aura-t-il lieu ?"
  
      puts "Quelle est la date de l'événement ? (format : AAAA-MM-JJ)"
      date = gets.chomp
  
      puts "À quelle heure ? (format : HH:MM)"
      time = gets.chomp
  
      start_date = "#{date} #{time}"
  
      puts "Au top. Combien de temps va-t-il durer (en minutes) ?"
      duration = gets.chomp.to_i
  
      puts "Génial. Qui va participer ? Balance leurs e-mails (séparés par des virgules)"
      attendees = gets.chomp.split(", ")
  
      event = Event.new(start_date, duration, title, attendees)
      puts "Super, c'est noté, ton évènement a été créé !"
      puts "Voici les détails de l'événement créé :"
      puts event.to_s
    end
  end
  

  class Calendar
    def initialize(events)
      @events = events
    end
  
    def display_calendar
      # Header
      puts "-------------------------------------------------------------"
      puts "|1       |2       |3      |4      |5      |6      |7        |"
      puts "|        |        |       |       |       |       |         |"
      puts "|        |        |       |       |       |       |         |"
      puts "|        |        |       |       |       |       |         |"
      puts "|        |        |       |       |       |       |         |"
      puts "-------------------------------------------------------------"
      puts "|         |       |       |       |       |                 |"
      puts "|         |       |       |       |       |                 |"
      puts "|         |       |       |       |       |                 |"
      puts "|         |       |       |       |       |                 |"
      puts "|         |       |       |       |       |                 |"
      puts "-------------------------------------------------------------"
      
      
      
  
      # Events
      (1..31).each_slice(7) do |week|
        print_day_events(week)
      end
  
      # Footer
      puts "-" * 81
    end
  
    private
  
    def print_day_events(week)
      week.each do |day|
        print "|"
        events_on_day = @events.select { |event| event.start_date.day == day }
        if events_on_day.empty?
          print " " * 8
        else
          print_event(events_on_day.size)
        end
        print " "
      end
      puts "|"
    end
  
    def print_event(events_count)
      print events_count.to_s.center(8)
    end
  end
  

# Création d'événements pour tester
Event.new("2024-04-05 09:00", 60, "Sandbox calendar challenge", ["participant1@example.com", "participant2@example.com"])
Event.new("2024-04-10 09:00", 60, "Post Profit challenge", ["participant3@example.com", "participant4@example.com"])
Event.new("2024-04-22 09:00", 60, "Another event", ["participant5@example.com"])

# Affichage du calendrier
events = Event.all
calendar = Calendar.new(events)
calendar.display_calendar

EventCreator.new
