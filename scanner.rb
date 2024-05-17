require 'net/http'
require 'uri'

def scan(url, file)
  uri = URI.join(url, file)
  response = Net::HTTP.get_response(uri)

  if response.code == "200"
    puts "   ✔️✔️ #{file} found at #{url} ✔️✔️"
  else
    puts " ✖️✖️ #{file} not found at #{url} ✖️✖️"
  end
rescue SocketError => e
  puts " ✖️✖️ Error: #{e.message} ✖️✖️"
end

# usage
puts " [*] Enter the website URL (e.g. http://example.com):"
url = gets.chomp

# Read the wordlist file
wordlist_path = "/usr/share/wordlists/dirb/common.txt"

begin
  files = File.readlines(wordlist_path).map(&:chomp)
rescue Errno::ENOENT
  puts " ✖️✖️ Wordlist file not found at #{wordlist_path} ✖️✖️"
  exit
end

files.each { |file| scan(url, file) }

