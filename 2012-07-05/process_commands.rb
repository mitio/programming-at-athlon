def process_commands(commands)
  commands.each do |arguments|
    command = arguments.shift

    return if command == :stop

    if command == :puts
      puts arguments.first
    elsif command == :inspect
      puts arguments.first.inspect
    elsif command == :object_id
      puts arguments.first.object_id
    elsif command == :call
      puts arguments.first.call(arguments.last)
    elsif command == :same_object?
      puts arguments.first.equal?(arguments.last)
    elsif command == :map_and_print
      mapped_list = arguments.first.map { |list_item| arguments[1].call(list_item) }
      puts mapped_list.join(', ')
    end
  end

  nil
end
