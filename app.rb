require_relative "repositories/meal_repository"
require_relative "repositories/customer_repository"
require_relative "controllers/customers_controller"
require_relative "controllers/meals_controller"
require_relative "router"

CSV_FILE_MEALS = File.join(__dir__, "data/meals.csv")
meal_repository = MealRepository.new(CSV_FILE_MEALS)
meals_controller = MealsController.new(meal_repository)

CSV_FILE_CUSTOMERS = File.join(__dir__, "data/customers.csv")
customer_repository = CustomerRepository.new(CSV_FILE_CUSTOMERS)
customers_controller = CustomersController.new(customer_repository)

router = Router.new(meals_controller, customers_controller)

# Start the app
router.run
