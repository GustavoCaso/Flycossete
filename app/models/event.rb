class Event < ActiveRecord::Base
  has_attached_file :photo,
    :styles => {
      :medium => "497x613>",
      :thumb => "200x200>"
    }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def fecha
    start_date.strftime("%Y-%B-%d")
  end
end
