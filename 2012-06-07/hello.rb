puts "Started!"

VAT_AMOUNT = 0.2
vat_amount = 0.3

def calculate_with_vat(price)
  foo = 5
  price + price * VAT_AMOUNT
end

puts("Result is: " + calculate_with_vat(100).inspect())

class String
  alias_method('old_plus', '+')

  def +(other)
    self.old_plus(other.to_s())
  end
end
