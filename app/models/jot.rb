class Jot < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  scope :hey, -> {
    where(message: 'hey')
  } #Jot.hey is now a class method returning all jots matching 'hey'

  scope :recent, -> (days=3) {
    where('created_at' > Time.current - days.days)
  } #Jot.recent returns jots made within the last 3 days

  scope :has_photo, -> {
    where('photo_file_name is not null')
  }
  #now Jot.recent.has_photo works

  has_attached_file :photo,
    styles: { medium: "300x300>" },
    default_url: "http://placehold.it/300x300",
    :storage => :s3,
    :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  geocoded_by :address

  #after_commit :extract_lat_lng, if: -> (jot) {jot.latitude.blank?}
  def s3_credentials
    {:bucket => ENV['S3_BUCKET'], :access_key_id => ENV['ACCESS_KEY'],
       :secret_access_key => ENV['SECRET_KEY']}
  end

  def liked_by(user)
    if self.likes.find_by_user_id(user.id)
      true
    else
      false
    end
  end
end
