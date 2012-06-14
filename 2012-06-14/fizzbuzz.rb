# A classical FizzBuzz implementation. Notice that
# the function's return value is actually the "return"
# value of the whole if/elsif/elsif/else construct.
def foobar_if(number)
  if number % 3 == 0 && number % 5 == 0
    "foobar"
  elsif number % 3 == 0
    "foo"
  elsif number % 5 == 0
    "bar"
  else
    "Sorry, I'm too drunk to divide."
  end
end

# An equivalent implementation, however this time
# we're using a postfix form of the `if` operator
# and also return statements, because we need them.
def foobar_postfix_if(number)
  return "foobar" if number % 3 == 0 && number % 5 == 0
  return "foo"    if number % 3 == 0
  return "bar"    if number % 5 == 0

  "Sorry, I'm too drunk to divide."
end

# This implementation is actually not a FizzBuzz,
# however we give it here to demonstrate the order of
# execution and the inverted `if` statement.
def foobar_concat(number)
  result = ''

  result << "foobar" if number % 3 == 0 && number % 5 == 0
  result << "foo"    if number % 3 == 0
  result << "bar"    if number % 5 == 0

  # "Sorry, I'm too drunk to divide."
  result
end

first_command_line_argument = ARGV[0]
puts foobar_concat(first_command_line_argument.to_i).upcase()
