class Cup
  def initialize(capacity, used)
    @capacity = capacity
    @used = used
  end

  def gulp
    amount = [@used, 30].min()
    @used -= amount
    puts "Gulped #{amount} ml!"
  end

  def plug(how_much)
    plugged = [how_much, @capacity - @used].min()
    extra = how_much - plugged
    @used += plugged
    puts "Plugged #{plugged} ml, spilled #{extra}!"
  end

  def peek
    puts "Used #{@used} ml of #{@capacity} ml."
  end
end

puts "Started!"

coffee_cup = Cup.new(100, 70)
beer_mug = Cup.new(1000, 1000)

coffee_cup.peek
coffee_cup.gulp
coffee_cup.gulp
coffee_cup.gulp
coffee_cup.gulp
coffee_cup.peek
coffee_cup.plug(125)

