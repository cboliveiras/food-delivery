require_relative '../models/meal'
require 'csv'

class MealRepository
  def initialize(csv_file)
    @meals = []
    @csv_file = csv_file
    @next_id = 1
    load_csv if File.exist?(csv_file)
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def find_index(id)
    @meals.find_index do |meal|
      meal.id == id
    end
  end
  def update(instance)
    index = find_index(instance.id)
    @meals[index] = instance
    save_csv
  end

  def destroy(id)
    @meals.delete_at(id)
    save_csv
  end

  def load_csv 
    # transformar cada linha em cabeçalho => headers _ first row
    # transformar key da hash em symbol => header_converters :symbol
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    @next_id = @meals.last.id + 1 unless @meals.empty?
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end