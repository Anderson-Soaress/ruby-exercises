class Game
  attr_accessor :cards, :suit

  def initialize
    @cards = ['A',2,3,4,5,6,7,8,9,'Q','J','K']
    @suit = ['♠','♥','♣','♦']
  end

  def print_cards(cards_array, who)
    a = 0

    for i in (who..(cards_array.length/2)) do
      puts "
      ━━━━━━━━━━━                       
      ┃#{cards_array[a]}        ┃          
      ┃#{cards_array[a+1]}        ┃        
      ┃    #{cards_array[a+1]}    ┃        
      ┃        #{cards_array[a+1]}┃
      ┃        #{cards_array[a]}┃
      ━━━━━━━━━━━
      "
      a += 2
    end

    puts transform_array(cards_array).map! {|item| item == 'A' ? item = 1 : item}.sum if who == 1
  end

  def timer
    puts "Press any button to continue"
    nothing = gets
  end

  def random_cards
    generated_cards = []
    for i in (1..2) do 
      generated_cards << cards.sample
      generated_cards << suit.sample
    end
    generated_cards
  end

  def buy_card(cards_array)
    cards_array << cards.sample
    cards_array << suit.sample
    cards_array
  end

  def transform_array(cards_array)
    cards_array = cards_array.dup
    letter = ['A','Q','J','K']
    cards_array.select!{|item| (2..9).include?(item) || letter.include?(item)}
    cards_array.map! {|item| item == 'K' || item =='Q' || item =='J' ? item = 10 : item}
    cards_array
  end

  def blackjack?(cards_array, type)
    cards_array = transform_array(cards_array)
    case type
    when 1
      cards_array.length == 2 && (cards_array.include?("A") && cards_array.include?(10)) ? true : false
    when 2
      cards_array.map! {|item| item == 'A' ? item = 1 : item}
      cards_array.sum == 21 ? true : false 
    end
  end

  def busted?(cards_array)
    cards_array = transform_array(cards_array)
    cards_array.map! {|item| item == 'A' ? item = 1 : item}
    cards_array.sum > 21 ? true : false
  end

  def winner(player, dealer)
    p player_cards_transformed = transform_array(player.cards).map! {|item| item == 'A' ? item = 1 : item}
    p dealer_cards_transformed = transform_array(dealer.cards).map! {|item| item == 'A' ? item = 1 : item}

    if !(player.busted) && (dealer.busted || (player_cards_transformed.sum > dealer_cards_transformed.sum))
      puts "You win!"
      player.blackjack = true
      timer()
    elsif !(dealer.busted) && (player.busted || (dealer_cards_transformed.sum > player_cards_transformed.sum))
      puts "The dealer wins!"
      dealer.blackjack = true
      timer()
    else
      puts "No winners!! It's a draw."
      timer()
    end

    puts "Your hand:"
    print_cards(player.cards,1)
    timer()
    puts "Dealer's hand: "
    print_cards(dealer.cards,1)
    timer()
  end

  def round 
    player = Player.new(random_cards)
    dealer = Dealer.new(random_cards)
    puts "This is your cards: "
    print_cards(player.cards,1)
    timer()
    puts "This is one of the dealer cards: "
    print_cards(dealer.cards,2)
    timer()
    
    if blackjack?(player.cards,1) 
      puts "You win!! Is a blackjack!"
      print_cards(player.cards,1)
      return player.blackjack = true
    end

    if blackjack?(dealer.cards,1)
      puts "The dealer wins! Is a blackjack!"
      print_cards(dealer.cards,1)
      return dealer.blackjack = true 
    end 

    until player.stop
      puts "Choose || 1- Buy card || Any button- Stop"
      choose = gets.chomp
      case choose
      when "1"
        player.cards = buy_card(player.cards)
      else
        player.stop = true
      end

      player.blackjack = blackjack?(player.cards, 2)
      break if player.blackjack

      player.busted = busted?(player.cards)
      break if player.busted

      puts "Your cards: "
      print_cards(player.cards,1)
    end

    while !(dealer.stop) && player.blackjack && player.busted
      dealer.dealer_limit
      break if dealer.stop

      dealer.blackjack = blackjack?(dealer.cards, 2)
      break if dealer.blackjack
      
      dealer.cards = buy_card(dealer.cards)
      dealer.busted = busted?(dealer.cards)
      break if dealer.busted
    end

    winner(player, dealer)
  end
end

class Player < Game
  attr_accessor :cards, :blackjack, :stop, :busted
  def initialize(cards)
    @cards = cards
    @blackjack = false
    @stop = false
    @busted = false
  end
end

class Dealer < Game
  attr_accessor :cards, :blackjack, :stop, :busted
  def initialize(cards)
    @cards = cards
    @blackjack = false
    @stop = false
    @busted = false
  end

  def dealer_limit
    cards_array = transform_array(self.cards)
    cards_array.map! {|item| item == 'A' ? item = 1 : item}
    cards_array.sum <= 16 ? true : self.stop = true
  end
end

play_game = Game.new
play_game.round