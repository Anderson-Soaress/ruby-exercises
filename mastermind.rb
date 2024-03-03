class Player

  attr_accessor :guessed_colors, :right_guesses, :attempts, :colors, :wrong_guesses, :board_guesses

  def initialize
    @guessed_colors = []
    @board_guesses = Array.new(4, " ")
    @right_guesses = 0
    @wrong_guesses = []
    @attempts = 1
    @colors = ['BLUE', 'YELLOW', 'GREEN', 'RED', 'PINK', 'PURPLE', 'ORANGE']
  end

  def guess_colors(random_colors) #Game mode: player guesses the computer colors

    selected_difficulty = 0

    until selected_difficulty.between?(1,4) do
      puts "\nSelect difficulty: \n1- Easy \n2- Normal \n3- Hard \n4- Impossible"
      selected_difficulty = gets.chomp.to_i
    end

    if selected_difficulty == 1 then self.attempts = 12
    elsif selected_difficulty == 2 then self.attempts = 8
    elsif selected_difficulty == 3  then self.attempts = 4
    else self.attempts = 2
    end

    until right_guesses == 4 || attempts == 0 do

      self.guessed_colors = []
      puts "Colors: #{(colors - wrong_guesses).join(", ")}." #Remove wrong colors(after user testing)
      puts "\nRemaining: #{attempts} attempts."
      puts "Right guesses: #{self.board_guesses.join(" | ")}. \nGuess: "
      for i in 1..4 do #Gets the inputs
      self.guessed_colors << gets.chomp.upcase
      end

      guessed_colors.each_with_index do |guessed_color, guessed_color_index|
        control_wrong = 0
        random_colors.each_with_index do |random_color, random_color_index|
          if random_color == guessed_color && random_color_index == guessed_color_index #Same color at the same index
            if !(self.board_guesses.include?(guessed_color)) #Test if the color has not already been added, to not add two times
              self.board_guesses[guessed_color_index] = guessed_color #Print the color in upcase, that means the color is right
              self.right_guesses += 1 #Loop control, if right guesses == 4 break the loop
            end
            break
          elsif random_color == guessed_color && random_color_index != guessed_color_index #Same color but not the same index
            self.board_guesses[guessed_color_index] = guessed_color.downcase #Print the color in downcase, means the color is right but wrong position
            break
          else
            control_wrong += 1
            if control_wrong == 4
              self.board_guesses[guessed_color_index] = "" #Clean the board if guess is wrong
              self.wrong_guesses << guessed_color #To remove wrong colors in line 32
            end
          end
        end
      end
      self.attempts -= 1 #Loop control, if attemps == 0 break the loop
    end

    if right_guesses == 4 #End game messages
      puts "\nNice! You win! \nRemaining attempts: #{attempts}"
      puts "\n#{self.board_guesses.join(" | ")}."
    else 
      puts "\nYou lose, try again."
      puts "\nYour last guess: #{guessed_colors.join(" | ")}\nRight sequence: #{random_colors.join(" | ")}"
    end
  end
end

class Computer
  attr_accessor :colors

  def initialize 
    @colors = ['BLUE', 'YELLOW', 'GREEN', 'RED', 'PINK', 'PURPLE', 'ORANGE']
  end

  def choose_colors
    random_colors = colors.sample(4) #Get four random itens from array colors
  end
end

class Game
  attr_accessor :player, :computer
  def initialize
    @player = Player.new
    @computer = Computer.new
  end

  def player_guess 
    random_colors = computer.choose_colors
    player.guess_colors(random_colors)
  end

end

play_game = Game.new
play_game.player_guess