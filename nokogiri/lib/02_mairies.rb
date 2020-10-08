require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'byebug'
require 'httparty'
$url = "http://annuaire-des-mairies.com/"


# get name parsed_page.xpath('//main[1] //div[1] //div[1] //div[1] //h1[1]').text.split("-")[0]
# get email adress parsed_page.xpath('//main[1] //section[2] //div[1] //table[1] //tbody[1] //tr[4] //td[2]').text



def get_townhall_email(url)
    h = {}
    h[Nokogiri::HTML(URI.open(url)).xpath('//main[1] //div[1] //div[1] //div[1] //h1[1]').text.split("-")[0].chop] = Nokogiri::HTML(URI.open(url)).xpath('//main[1] //section[2] //div[1] //table[1] //tbody[1] //tr[4] //td[2]').text
    return h
end

def get_townhall_urls
    cities = []
    parsed_page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
    parsed_page.css('a.lientxt').map do |city|
        cities.push(get_townhall_email($url + (city["href"].reverse.chop.reverse) ))
    end
    return cities
end

def scrapper
    parsed_page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/ambleville.html"))
    byebug
end

puts get_townhall_urls