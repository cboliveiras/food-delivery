require_relative "../models/customer"
require "csv"

class CustomerRepository
  def initialize(csv_file)
    @customers = []
    @csv_file = csv_file
    @next_id = 1
    load_csv if File.exist?(csv_file)
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  def find_index(id)
    @customers.find_index do |customer|
      customer.id == id
    end
  end

  def update(instance)
    index = find_index(instance.id)
    @customers[index] = instance
    save_csv
  end

  def destroy(id)
    @customers.delete_at(id)
    save_csv
  end

  def load_csv
    # transformar cada linha em cabeçalho => headers _ first row
    # transformar key da hash em symbol => header_converters :symbol
    #"No csv file found." if File.exist?('csv_file') == false
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
