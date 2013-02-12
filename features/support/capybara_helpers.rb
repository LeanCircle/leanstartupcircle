module CapybaraHelpers
  def wait_for_page_load
    start = Time.now
    while true
      break if page.evaluate_script('$.active') >= 0
      if Time.now > start + 10.seconds
        fail "Time limit error. Please try again later."
      end
      sleep 0.1
    end
  end
end

Cucumber::Rails::World.send(:include, CapybaraHelpers)
