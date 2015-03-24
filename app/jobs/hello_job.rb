class HelloJob < ActiveJob::Base
  queue_as :default

  def perform (throw_ex=false)
    if throw_ex
      raise "You made a mistake!"
    end 
    sleep 5
    puts "I'm in a job"
    logger.info "background job!"
  end
end
