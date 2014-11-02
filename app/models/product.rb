class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :photo,
    :styles => {
      :medium => "x613",
      :thumb => "x200"
    }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates_numericality_of :stock, {greater_than_or_equal_to: 0}
  validates_presence_of :name, message: "Nombre no puede estar en blanco"
  validates_presence_of :description, message: "Descripción no puede estar en blanco"
  validates_presence_of :short_description, message: "Descripción corta no puede estar en blanco"
  validates_presence_of :category, message: "Categoria no puede estar en blanco"
  validates_presence_of :price, message: "Precio no puede estar en blanco"
  validates_presence_of :size, message: "Talla no puede estar en blanco"

  CATEGORY = ["Jersey", "Pantalones", "Vestidos/Faldas", "Camisas", "Chaquetas/Blazer", "Complementos", "Botas", "Outlet"]

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end

end
