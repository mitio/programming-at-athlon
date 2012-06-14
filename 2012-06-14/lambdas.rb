# Lambdas, or anonymous functions or closures--all different names for
# the same thing. Lambdas exist in other languages, too, in one form or
# another and are a very convenient abstraction tool.

# This function is supposed to calculate an order total. It is aware
# that orders can have discounts, however it doesn't impose any restrictions
# on how exactly that discount is calculated. This knowledge is passed on
# to the calculate_order_total() method in the form of an optional lambda
# function. If a discount calculation function is present (ie. the variable
# discount_calculator is not nil), then this lambda is executed via its call()
# method and its return value is used as the discount.
def calculate_order_total(item1_amount, item2_amount, item3_amount, discount_calculator)
  total = item1_amount + item2_amount + item3_amount

  if discount_calculator != nil
    total = total - discount_calculator.call(total)
  end

  total
end

# An example with a 10% discount.
order_total = calculate_order_total(10.00, 10, 5, lambda { |amount| amount * 0.1 })
puts "Your total is: #{order_total}"

# The same 10% discount, just using the "modern" (Ruby 1.9) lambda syntax,
# and also assigning the discount lambda to a variable, just for convenience
# and eventually for a possible later reuse. It is syntactically the same as:
#
#   ten_percent_discount = lambda { |amount| amount * 0.1 }
ten_percent_discount = -> amount { amount * 0.1 }

order_total = calculate_order_total(10.00, 10, 5, ten_percent_discount)
puts "Your total is: #{order_total}"

order_total = calculate_order_total(10.00, 10, 5, lambda { |amount|
  if amount > 100
    amount * 0.3
  else
    5
  end
})
puts "Your total is: #{order_total}"


# Another example of using lambdas--as a "callback" function. For example,
# this piece of code below simulates some heavy working method and in
# some points of the work, problems might be detected. When that happens,
# the worker would want to notify the caller for the problem somehow.
# One way to achieve this might be via the use of "callback" functions.
# The callback function is just a regular lambda.
#
# The function definition of this worker also demonstrates briefly
# what "optional function arguments" are. This particular function definition
# allows us to call the function with either one or with two arguments.
# In the former case, the last argument will be nil.
def do_something_heavy_and_error_prone(args, in_case_of_an_error = nil)
  # ...
  # Perform some work.
  # ...

  something_weird_happened = false

  if something_weird_happened && in_case_of_an_error != nil
    in_case_of_an_error.call("This is the error message -- a description of what really went wrong")
    return
  end

  # ...
  # Perform more work.
  # ...
end

# We then can call the worker with no last argument, we say that
# we don't care for any possible errors and we're not interested
# in logging them anywhere.
do_something_heavy_and_error_prone("dsfsdf")

# We can, however, also call the worker with an error handler
# lambda we have written, which just prints the error on the console.
do_something_heavy_and_error_prone("dsfsdf", -> error_message { puts error_message })

# This is useful, because in case we're running in a program
# which is not attached to a screen, such as a server process/daemon,
# we might want to log this message somewhere else, for example
# in a database. The "error callback" lambda abstraction allows
# us to do so without requiring any changes in the worker.
database_logger = -> message { DatabaseLogger.log(message) }
do_something_heavy_and_error_prone("dsfsdf", database_logger)
