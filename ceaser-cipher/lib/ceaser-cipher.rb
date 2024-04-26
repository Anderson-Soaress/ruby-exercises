def cipher(word_letter, shift, max)
  word_letter = word_letter.ord + shift 
  if word_letter > max 
    word_letter -= 26
  end
  word_letter.chr
end

def ceaser_cipher (word, shift)
  cipher = [] 
  word_letters = word.split("")
  word_letters.each do |word_letter|
    if word_letter.ord.between?(97,122) #convert lower case letters
      cipher << cipher(word_letter, shift, 122)
    elsif word_letter.ord.between?(65,90) #convert upper case letters
      cipher << cipher(word_letter, shift, 90)
    else  #if not a letter just add
      cipher << word_letter
    end
  end
  cipher.join("")
end