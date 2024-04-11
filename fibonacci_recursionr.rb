def fibs(n, fib_seq = [0,1])
  if n <= 0 
    return
  elsif n == 1
    return[0]
  else
    until fib_seq.length == n
      fib_seq << fib_seq[fib_seq.length-1] + fib_seq[fib_seq.length-2]
    end
    return fib_seq
  end
end

def fibs_rec(n, fib_seq = [0,1])
  if n <= 0
    return
  elsif n == 1
    return [0]
  elsif fib_seq.length == n
    return fib_seq
  else
    fib_seq << fib_seq[fib_seq.length-1] + fib_seq[fib_seq.length-2]
    fibs(n,fib_seq)
  end
end