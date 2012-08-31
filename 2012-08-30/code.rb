class Array
  def index_by(izraz)
    evaluation = {}
    each { |x| evaluation[izraz.call(x)] = x }
    evaluation
  end

  def returning(object)
    yield(object)
    object
  end
end

name = ->(object) { object.name }
name = :name.to_proc

class Symbol
  def to_proc
    -> object { object.send(self) }
  end
end

class Person
  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end
end

:name.to_proc.call(Person.new)

elenko = Person.new
elenko.name = 'Elenko!'

:name.to_proc.call(elenko)

# Using a block
[1, -2, -3].map() { |number| number.to_s }

# Using a lambda/proc, passed on as a block via "&"
[1, -2, -3].map(&->(number) { number.to_s })

# Using something.to_proc and &
[1, -2, -3].map(&:to_s.to_proc)

# Ruby calls #to_proc behind the scenes
[1, -2, -3].map(&:to_s)
