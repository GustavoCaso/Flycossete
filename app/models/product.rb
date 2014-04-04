class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :photo,
    :styles => {
      :medium => "497x613>",
      :thumb => "100x100>"
    }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  CATEGORY = ["Jersey", "Pantalones", "Faldas", "Camisas", "Camisetas", "Complementos", "Botas", "Outlet"]

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
