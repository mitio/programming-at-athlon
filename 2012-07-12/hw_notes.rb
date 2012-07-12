class Array
  def to_hash
    hash = {}
    self.each do |key, value|
      hash[key] = value
    end
    hash
  end

  # ['John Coltrane', 'Miles Davis'].index_by(lambda { |name| name.split(' ').last })
  # # Очакван резултат: {'Coltrane' => 'John Coltrane', 'Davis' => 'Miles Davis' }
  def index_by(command)
    hash = {}
    each do |value|
      key = command.call(value)
      hash[key] = value
    end
    hash
  end

  def subarray_count(subarray)
    counter = 0

    length.times do |position|
      counter += 1 if self[position ... position + subarray.length] == subarray
    end

    counter
  end

  def subarray_count_by_plamen(subarray)
    position = -1
    count { subarray == self[position += 1, subarray.length] }
  end

  def occurences_count
    result = Hash.new(0)
    # [:a, :b, :a]
    # {:a => 2, :b => 1}
    each do |element|
      result[element] = count(element) unless result.has_key?(element)
    end
    result
  end
end
