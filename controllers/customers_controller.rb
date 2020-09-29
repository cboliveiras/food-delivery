require_relative "../models/customer"
require_relative "../repositories/customer_repository"
require_relative "../views/customer_view"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomerView.new
  end

  def add
    name = @view.ask_user("name")
    id = @next_id
    address = @view.ask_user("address")
    customer = Customer.new(id: id, name: name, address: address)
    @customer_repository.create(customer)
    @view.display(@customer_repository.all)
  end

  def destroy
    # 1. Display recipes
    @view.display(@customer_repository.all)
    # 2. Ask user for index (view)
    id = @view.id
    # 3. Remove from (repo)
    @customer_repository.destroy(id)
    # 4. Display
    @view.display(@customer_repository.all)
  end

  def edit
    @view.display(@customer_repository.all)
    id = @view.ask_user("ID#").to_i
    customer = @customer_repository.find(id)
    option = @view.show_edit_customer(customer)
    case option
    # aqui o objeto.name ou .price trocou de valor e esta salvo na memoria
    when 1
      value = @view.ask_user("new name")
      customer.name = value
    when 2
      value = @view.ask_user("new address")
      customer.address = value
    end
    # aqui foi feito o update/save_csv com o objeto inteiro com a instancia refatorada
    @customer_repository.update(customer)
  end

  def list
    customers = @customer_repository.all
    if customers.empty?
      @view.any_stuff_yet("customer")
    else
      @view.display(customers)
    end
  end
end
