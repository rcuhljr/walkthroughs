class Game

  def initialize()
    @current_room = nil #replace with starting room
    @inventory = []
    @rooms = {}
  end
  
  def populate_rooms
    
    start_room = {description:"The First Room.", exits:[["E", 2]], actions:[["wave", nil]], items:["sandwich"]}
    second_room = {description:"The Second Room.", exits:[["W", 1]], actions:[["wave", nil], ["feed","sandwich"]], items:[]}
    
    @rooms = {}
    
    @rooms[1] = start_room
    @rooms[2] = second_room
    
    return start_room
  end
  
  def display_room
    puts
    puts @current_room[:description]
    puts "Exits:" + @current_room[:exits].map{|x| x[0] }.join(", ")    
  end
  
  def start()
    while(run) do

    end    
  end
  
  def run()    
    if @current_room == nil 
      @current_room = populate_rooms 
      display_room
    end
    print "\n>"
    input = gets.chomp()
    
    return false if input == "exit"
    
    return true
  end

end


a_game = Game.new

a_game.start