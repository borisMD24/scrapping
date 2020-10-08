require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'byebug'

$url = "http://www2.assemblee-nationale.fr/deputes/liste/tableau"

$root = "http://www2.assemblee-nationale.fr"


def scrapp_mail_by_url(sub)
    r = Nokogiri::HTML(URI.open($root + sub)).css('dl.deputes-liste-attributs').xpath('dd[4]/ul[1]/li[1]/a[1]').first
    if r.inspect == "nil"
        return "could'nt scrap this information but if you want it, here's the url to fecth it : #{$root + sub}"
    end
    return r["href"].split(":")[1]

end


def scrapper
    names = []
    parsed_page = Nokogiri::HTML(URI.open($url))
    i = parsed_page.css('.deputes').css('tr').xpath('//td[1]/a')
    i.each do |name|
        h = {}
        h[name.text] = scrapp_mail_by_url(name["href"])
        names << h
    end
    return names
end

puts scrapper