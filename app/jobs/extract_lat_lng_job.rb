class ExtractLatLngJob < ActiveJob::Base
  queue_as :default

  def perform(jot)
    # Do something later
    gps = EXIFR::JPEG.new(jot.photo.path).gps
    if gps
      jot.update(latitude: gps.latitude, longitude:gps.longitude)
    end
  end
end
