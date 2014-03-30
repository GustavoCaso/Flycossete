class Product < ActiveRecord::Base

  has_attached_file :photo,
    :styles => {
      :medium => "497x613>",
      :thumb => "100x100>"
    }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  CATEGORY = ["Jersey", "Pantalones", "Faldas", "Camisas", "Camisetas", "Complementos", "Botas", "Outlet"]

end
