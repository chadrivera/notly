class ExtractLatLngJob < ActiveJob::Base
  queue_as :default

  def perform(jot)
    # Do something later
    gps = EXIFR::JPEG.new(jot.photo_path).gps
    jot.update(latitude: gps.latitute, longitude:gps.longitude)
  end
end
