require 'nokogiri'
require 'bitly'

module Newsletter
  class Parser

    def self.replace_links(dom)
      links = dom.css('a')
      links.each do |link|
        href = link[:href]
        new_href = yield href
        link[:href] = new_href
      end
    end

  end
end


Bitly.use_api_version_3
bitly = Bitly.new("o_l6o8q5edn", "R_c01a39b315193dc25254ec616c124db6")

File.open(ARGV[0]) do |f|
  content = f.read
  fragment = Nokogiri::HTML::DocumentFragment.parse(content)
  Newsletter::Parser.replace_links(fragment) do |href|
    u = bitly.shorten(href)
    href = u.short_url
  end
  print fragment.to_s
end
