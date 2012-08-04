class Subdomain
  def self.matches?(request)
    request.subdomain == 'jobs'
  end
end