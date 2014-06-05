class Event < ActiveRecord::Base
  has_attached_file :photo,
    :styles => {
      :medium => "1170"
    }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :name, message: "Nombre no puede estar en blanco"
  validates_presence_of :description, message: "La descripción no puede estar en blanco"
  validates_presence_of :short_description, message: "La descrición corta no puede estar en blanco"
  validates_presence_of :start_date, message: "La fecha de comienzo no puede estar en blanco"

  def date
    start_date.strftime("%Y-%B-%d")
  end
end
