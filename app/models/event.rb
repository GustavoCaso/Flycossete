class Event < ActiveRecord::Base
  has_attached_file :photo,
    :styles => {
      :medium => "1170"
    }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def date
    start_date.strftime("%Y-%B-%d")
  end
end
