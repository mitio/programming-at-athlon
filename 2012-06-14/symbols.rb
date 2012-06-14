# encoding: utf-8
#
# Attempt to demonstrate a use case for the symbol type
# in Ruby. The symbol is much like a string, however it
# can't actually be changed and is not garbage collected.
#
# Try this in your irb console, for example:
#
#   ''.object_id
#   ''.object_id
#   ''.object_id
#
# You should see different values for the object_id for each
# string, although the string has the same content each time.
# This shows that Ruby creates a new object for each string
# each time and after we're done using it, Ruby makes sure
# the object is destroyed. Thus, it is never reused.
#
# With symbols, however, once we "create" a symbol, it is
# never freed by Ruby and all later occurances of that symbol
# are actually the same object. You can make sure this is so
# by running a few times this in an irb session:
#
#   :test.object_id
#   :test.object_id
#   :test.object_id
#
# All of the above should return the same object_id, indicating
# that actually the object is the same in all three cases.

def infer_gender(name)
  if name.end_with?("ов")
    :male
  elsif name.end_with?("ова")
    :female
  end
end

print "Your name: "
your_name = gets.strip
gender = infer_gender(your_name)

greeting = if gender == :male
  "Уважаеми господин #{your_name},"
elsif gender == :female
  "Уважаема госпожо #{your_name},"
else
  "Уважаемо #{your_name},"
end

puts greeting
