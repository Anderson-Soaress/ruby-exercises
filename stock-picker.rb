def stock_picker(days)
  best_profit = 0
  best_days = []
  days.each_with_index do |buy, buy_index|
    days.each_with_index do |sell, sell_index|
      profit = sell - buy 
      if profit > best_profit && sell_index > buy_index
        best_days = [buy_index, sell_index]
        best_profit = profit
      end
    end
  end
  p best_days 
end
stock_picker([17,3,6,9,15,8,6,1,10]) # best day to buy index = 1 to sell index = 4