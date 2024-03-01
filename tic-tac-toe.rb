class Player

  attr_accessor :moves, :choice, :positions, :symbol, :points, :winner, :name

  def initialize(player_symbol)
    @name = ""
    @symbol = player_symbol
    @moves = []
    @choice = 0
    @points = 0
    @winner = false
  end

  def choices(player_choice)
    self.choice = player_choice
    moves << player_choice
  end
end

class Game

  attr_accessor :positions, :player1, :player2, :win_points, :positions_selected, :tie

  def initialize
    @positions = (1..9).to_a
    @positions_selected = 0
    @tie = false
    @player1 = Player.new("X")
    @player2 = Player.new("O")

    puts "Type the player 1 name: "
    player1.name = gets.chomp
    puts "\nType the player 2 name: "
    player2.name = gets.chomp
    puts "\nType how many points to win: "
    @win_points = gets.chomp.to_i

    best_of()
  end

  def board(symbol)
    self.positions.each_with_index do |position, index|
      if symbol = "X" && position == player1.choice 
        self.positions[index] = "X" 
      elsif symbol = "O" && position == player2.choice
        self.positions[index] = "O"
      end 
    end #Only visual: change the position number to X or O
    puts "
    #{positions[0]} | #{positions[1]} | #{positions[2]}
    --------- 
    #{positions[3]} | #{positions[4]} | #{positions[5]} 
    ---------
    #{positions[6]} | #{positions[7]} | #{positions[8]}"
  end

  def scoreboard
    if player1.points == win_points
      puts "#{player1.name} wins the series!!"
      player1.winner = true
    elsif player2.points == win_points
      puts "#{player2.name} wins the series!!"
      player2.winner = true
    end

    if tie
      puts "\nNo winners!! It's a tie."
    end

    puts "\n#{player1.name} #{player1.points} X #{player2.points} #{player2.name}"
  end

  def win?(player)
    win_conditions = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]] #All combinations to win

    win_conditions.each do |win_condition|
      if (win_condition - player.moves).empty? #If the arrays diff is an empty array, it means that the player wins
        player.points += 1
        return true # Add 1 point and return true to break the loop
      end
    end
    
    if positions_selected == 9 #If after 9 moves no one wins, it's a tie and return true to break the loop
      self.tie = true
      return true
    end

    return false #If the above conditions are false, return false and the loop will continue until they are true.
  end

  def reset 
    player1.moves = []
    player1.choice = 0

    player2.moves = []
    player2.choice = 0

    self.positions_selected = 0
    self.positions = (1..9).to_a
  end

  def get_input(player) 
    valid_inputs = (1..9).to_a
    valid_answer = false
    puts "\n#{player.name} choose: " 
    until valid_answer do
      user_input = gets.chomp.to_i #Get the input
      if valid_inputs.include?(user_input) #Check if is valid(a number between 1 and 9)
        if !(player1.moves.include?(user_input)) && !(player2.moves.include?(user_input)) #Check if is already chose
          player.choices(user_input) #Store the input 
          valid_answer = true #Break the loop
          self.positions_selected += 1 #To check later if is a tie
        else 
          puts "\nThis position has already been selected, please choose a valid number: "
        end
      else
        puts "\nYour choose is not valid, please type a number between 1 and 9: "
      end
    end
  end

  def play_round
    finish = false
    reset()
    board(0)

    until finish do 
      get_input(player1)
      board("X")

      break if win?(player1)

      get_input(player2)
      board("O")

      break if win?(player2)

    end 
  end

  def best_of
    until player1.winner || player2.winner
      play_round()
      scoreboard()
    end
  end

end

play_game = Game.new