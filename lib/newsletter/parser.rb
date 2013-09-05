require 'trollop'
require 'nokogiri'
require 'bitly'

module Newsletter
  class Parser

    def self.replace_links(dom)
      links = dom.css('a')
      links.each do |link|
        url = link[:href]
        new_url = yield url
        link[:href] = new_url
      end
    end

  end
end

# get command line options
opts = Trollop::options do
  opt :infile, "file containing urls to be converted", :type => :string
  opt :utm_source, "how/where newsletter will be sent", :type => :string
  opt :date, "newsletter date", :type => :string
  opt :outfile, "converted file (existing file will be overwritten)", :type => :string
end
Trollop::die :infile, "must be specified" if opts[:infile] == nil
Trollop::die :infile, "must exist" unless File.exist?(opts[:infile])
Trollop::die :utm_source, "must be specified" if opts[:utm_source] == nil
Trollop::die :date, "must be specified" if opts[:date] == nil
Trollop::die :outfile, "must be specified" if opts[:outfile] == nil

Bitly.use_api_version_3
bitly = Bitly.new("o_l6o8q5edn", "R_c01a39b315193dc25254ec616c124db6")

File.open(opts[:infile]) do |infile|
  content = infile.read
  fragment = Nokogiri::HTML::DocumentFragment.parse(content)
  Newsletter::Parser.replace_links(fragment) do |url|
    url = url + "?utm_source=" + opts[:utm_source] + "&utm_medium=email&utm_campaign=lsc_newsletter_" + opts[:date]
    u = bitly.shorten(url)
    url = u.short_url
  end

  File.open(opts[:outfile], "w") do |outfile|
    outfile.print fragment.to_s
  end
end

