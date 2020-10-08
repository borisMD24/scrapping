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

def name_decomposer(name)
    h = {}
    h["first_name"] = name.split(" ")[1]
    h["last_name"] = name.split(" ")[2]
    return h
end

def scrapper
    names = []
    parsed_page = Nokogiri::HTML(URI.open($url))
    i = parsed_page.css('.deputes').css('tr').xpath('//td[1]/a')
    i.each do |name|
        h = name_decomposer(name.text)
        h["email"]= scrapp_mail_by_url(name["href"])
        names << h
    end
    return names
end

puts scrapper