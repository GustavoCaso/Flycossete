module ProductsHelper
  def number_to_euro number
    content_tag(:p, class: "euros" ) do
      number_to_currency(number, unit: "€", precision: 2, format:   "%n %u")
    end
  end
end
