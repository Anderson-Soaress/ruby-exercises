def bubble_sort(numbers)
  isSort = false
  until isSort
    test = 0
    numbers.each_with_index do |number, index|
      next_number = numbers[index+1]
      if index+1 < numbers.length && number > next_number
        numbers[index+1] = number
        numbers[index] = next_number
      else
        test += 1
        if test == numbers.length-1
          isSort = true
        end
      end
    end
  end
  p numbers
end

bubble_sort([4,3,78,2,0,2]) #[0,2,2,3,4,78]
