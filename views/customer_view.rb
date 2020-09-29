class CustomerView
  def display(customers)
    @customers = customers
    customers.each do |customer|
      #status = customer.done ? "[x]" : "[ ]"
      puts "#{customer.id} - #{customer.name} - #{customer.address}"
    end
  end

  def ask_user(stuff)
    puts "What's the #{stuff} of the customer?"
    print "> "
    gets.chomp
  end

  def any_stuff_yet(stuff)
    puts "You don't have any #{stuff} yet."
  end

  def id
    puts "ID?"
    print "> "
    gets.chomp.to_i - 1
  end

  def show_edit_customer(customer)
    puts "Name: #{customer.name}  Address:#{customer.address}"
    puts "What # would you like to edit?"
    puts "1 - Name"
    puts "2 - Address"
    print "> "
    gets.chomp.to_i
  end
end
