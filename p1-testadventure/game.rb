class Game

  def initialize()
    @current_room = nil #replace with starting room
    @inventory = []
    @rooms = {}
  end
  
  def populate_rooms
    
    start_room = {description:"The First Room.", exits:[["E", 2, /^([\w]+ )e$|^([\w]+ )east$|e$|^east$/i]], actions:[["wave", nil]], items:["sandwich"]}
    second_room = {description:"The Second Room.", exits:[["W", 1,/^([\w]+ )w$|^([\w]+ )west$|w$|^west$/i]], actions:[["wave", nil], ["feed","sandwich"]], items:[]}
    
    @rooms = {}
    
    @rooms[1] = start_room
    @rooms[2] = second_room
    
    return start_room
  end
  
  def get_room_display    
    item_string = @current_room[:items].length > 0 ? "Items: " + @current_room[:items].join(", ")  : ""
    @current_room[:description] + "\n" + item_string + "Exits: " + @current_room[:exits].map{|x| x[0] }.join(", ")
  end
  
  def parse_input(input)
    
    result = parse_exits(input)
    return result unless result.nil?
    
    result = parse_actions(input)
    return result unless result.nil?    
    
    return "Unrecognized command."
  end
  
  def parse_actions(input)
    
    return get_room_display if input =~ /^look$/i
    
    if input =~ /^get ([\w])+/i
      get_item($1)

    end
  
  
    return nil
  end
  
  def parse_exits(input)
    exits = @current_room[:exits]
    exit = exits.select{|x| input =~ x[2] }
    if exit.length > 1
      return "ambiguous direction, please be more specific."
    end
    if exit.length == 1
      @current_room = @rooms[exit[0][1]]      
      return get_room_display
    end
    return nil
  end
  
  def start()
    while(run) do
    end    
    puts "Thanks for playing, see you next time."
  end
  
  def run()    
    if @current_room == nil 
      @current_room = populate_rooms 
      puts get_room_display
    end
    print "\n>"
    input = gets.chomp()
    
    return false if input =~ /^exit.*/i
    
    response = parse_input input
    puts response
    
    return true
  end

end


a_game = Game.new

a_game.start