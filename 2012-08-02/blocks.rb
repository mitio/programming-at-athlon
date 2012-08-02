def prime?(number)
  (2..Math.sqrt(number).ceil).none? { |divisor| number % divisor == 0 }
end

def each_prime_upto(limit)
  (1..limit).each do |number|
    yield(number) if prime?(number)
  end
end
