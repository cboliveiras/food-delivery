class MealView
  def display(meals)
    @meals = meals
    meals.each do |meal|
      #status = meal.done ? "[x]" : "[ ]"
      puts "#{meal.id} - #{meal.name} - US$#{meal.price}"
    end
  end

  def ask_user(stuff)
    puts "What's the #{stuff} of the meal?"
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

  def show_edit_meal(meal)
    puts "Name: #{meal.name} - Price: US$#{meal.price}"
    puts "What # would you like to edit?"
    puts "1 - Name"
    puts "2 - Price"
    print "> "
    gets.chomp.to_i
  end
end
