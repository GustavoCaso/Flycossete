module ProductsHelper
  def number_to_euro number
    number_to_currency(number, unit: "€", precision: 2, format:   "%n %u")
  end
end
