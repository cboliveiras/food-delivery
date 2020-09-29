require_relative "../models/meal"
require_relative "../repositories/meal_repository"
require_relative "../views/meal_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def add
    name = @view.ask_user("name")
    id = @next_id
    price = @view.ask_user("price").to_i
    meal = Meal.new(id: id, name: name, price: price)
    @meal_repository.create(meal)
    @view.display(@meal_repository.all)
  end

  def edit
    @view.display(@meal_repository.all)
    id = @view.ask_user("ID#").to_i
    meal = @meal_repository.find(id)
    option = @view.show_edit_meal(meal)
    if option == 1 # aqui o objeto.name ou .price trocou de valor e esta salvo na memoria
      meal.name = @view.ask_user("new name")
    else
      meal.price = @view.ask_user("new price")
    end
    @view.display(@meal_repository.all)
  end

  def destroy
    # 1. Display recipes
    @view.display(@meal_repository.all)
    # 2. Ask user for index (view)
    id = @view.id
    # 3. Remove from (repo)
    @meal_repository.destroy(id)
    # 4. Display
    @view.display(@meal_repository.all)
  end

  def list
    meals = @meal_repository.all
    if meals.empty?
      @view.any_stuff_yet("meal")
    else
      @view.display(meals)
    end
  end
end
