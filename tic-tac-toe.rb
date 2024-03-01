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

  attr_accessor :positions, :player1, :player2, :win_points

  def initialize
    @positions = [1,2,3,4,5,6,7,8,9]
    @player1 = Player.new("X")
    @player2 = Player.new("O")

    puts "Type the player 1 name: "
    player1.name = gets.chomp
    puts "Type the player 2 name: "
    player2.name = gets.chomp
    puts "Type how many points to win: "
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
    end
    puts "\n#{positions[0]} | #{positions[1]} | #{positions[2]} \n#{positions[3]} | #{positions[4]} | #{positions[5]} \n#{positions[6]} | #{positions[7]} | #{positions[8]}"
  end

  def scoreboard
    if player1.points == win_points
      puts "#{player1.name} wins the series!!"
      player1.winner = true
    elsif player2.points == win_points
      puts "#{player2.name} wins the series!!"
      player2.winner = true
    end
    puts "#{player1.name} #{player1.points} X #{player2.points} #{player2.name}"
  end

  def win?(player)
    win_conditions = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    win_conditions.each do |win_condition|
      if (win_condition - player.moves).empty?
        player.points += 1
        return true
      end
    end
    return false
  end

  def reset
    player1.moves = []
    player1.choice = 0

    player2.moves = []
    player2.choice = 0

    self.positions = [1,2,3,4,5,6,7,8,9]
  end

  def play_round
    finish = false
    reset()
    board(0)
    until finish do 
      puts "\n#{player1.name} choose: "
      player1_gets = gets.chomp.to_i
      player1.choices(player1_gets)
      board("X")

      break if win?(player1)

      puts "\n#{player2.name} choose:"
      player2_gets = gets.chomp.to_i
      player2.choices(player2_gets)
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