class Game

  def initialize()
    @current_room = nil 
    @inventory = []
    @rooms = {}
  end
  
  def populate_rooms
    
    start_room = {description:"The First Room.", exits:[["E", 2, /^([\w]+ )e$|^([\w]+ )east$|^e$|^east$/i]], actions:[["wave", nil]], items:["sandwich"]}
    second_room = {description:"The Second Room.", exits:[["W", 1,/^([\w]+ )w$|^([\w]+ )west$|^w$|^west$/i]], actions:[["wave", nil], ["feed","sandwich"]], items:[]}
    
    @rooms = {}
    
    @rooms[1] = start_room
    @rooms[2] = second_room
    
    return start_room
  end
  
  def get_room_display    
    item_string = @current_room[:items].length > 0 ? "Items: " + @current_room[:items].join(", ") + "\n"  : ""
    @current_room[:description] + "\n" + item_string + "Exits: " + @current_room[:exits].map{|x| x[0] }.join(", ")
  end
  
  def parse_input(input)
    
    result = parse_exits(input)
    return result unless result.nil?
    
    result = parse_actions(input)
    return result unless result.nil?    
    
    return "Invalid command."
  end
  
  def get_item(item)
    #puts "room_actions(#{item})"
    items = @current_room[:items]
    if items.find_index(item)
      @inventory.push(item)
      items.delete(item)
      return "You pickup #{item}."
    end
    return "Couldn't find #{item}."
  end
  
  def room_actions(input)
    puts "room_actions(#{input})"
    action = @current_room[:actions].select{|x| input == x[0] }[0]
    puts "found action #{action}"
    if not action.nil?       
      return "You wave!" if action[0] == "wave"
      if action[0] == "feed"
        return "You don't have a #{action[1]}." unless @inventory.find_index(action[1])
        @inventory.delete(action[1])
        return "You feed the sandwich to a hungry grue."
      end
    end
    return nil
  end
  
  def get_inventory_display    
    return "You don't have anything!" if @inventory.length == 0
    return "Inventory: " +@inventory.join(", ")
  end
  
  def parse_actions(input)
    #puts "parse_actions(#{input})"
    return get_room_display if input =~ /^look$/i
    
    return get_item($1) if input =~ /^get ([\w]+)/i        
    
    return get_inventory_display if input =~ /^inv$/i
    
    return result = room_actions(input) if input =~ /^[\w]+$/i   
  
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