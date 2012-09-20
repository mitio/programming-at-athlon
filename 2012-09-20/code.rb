class FibonacciNumbers
  include Enumerable

  def initialize(limit)
    @limit = limit
  end

  def each
    current, previous = 1, 0

    while current < @limit
      yield current
      current, previous = current + previous, current
    end
  end
end
