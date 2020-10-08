require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'byebug'
require 'httparty'
$url = "https://coinmarketcap.com/all/views/all/"

def get_crypto_names
    titles = []
    parsed_page = Nokogiri::HTML(HTTParty.get($url)).css("div.sc-1kxikfi-0 a.cmc-link").map do |title| 
        titles.push(title.children.text) 
        puts("got name of #{title.children.text} in index = #{titles.length-1}")
    end
    puts "could scrap #{titles.length} name entries"
    return titles
end

def get_crypto_values
    values = []
    parsed_page = Nokogiri::HTML(HTTParty.get($url)).css('td[5]/a').map do |value| 
        values.push(value.children.text)
        puts("got value of #{value.children.text} in index = #{values.length-1}")
    end
    puts "could scrap #{values.length} values entries"
    return values
end

def scrapper
    parsed_page = Nokogiri::HTML(HTTParty.get($url))
    byebug
end

def get_hash_crypo_values()
    h={}
    get_crypto_names.zip(get_crypto_values) { |a,b| h[a.to_sym] = b }
    puts h
end

#get_crypto_values

#get_crypto_values

#titles : pared_page.css("div.sc-1kxikfi-0 a.cmc-link")
#access to text : [n].children.text

#access to rows;
=begin
 on sait que    line 1, valeur est row 1
                line 2, valeur est row 9
                line 3, valeur est row 17
=end
#crypto_names = get_crypto_names

puts get_hash_crypo_values