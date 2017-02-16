require 'oauth'
require 'json'
def usage()
	puts "generates files from the twitter API that can be loaded by aggrigator.rb"
	puts "to run, you need 'oauth' and 'json' gems, and need a twitter dev account and oath token."
	puts "ruby agitator.rb <twitter_handle> <API_Key> <API_Secret> <AccessToken> <AccessSecret>"
	puts "e.g. ruby agitator.rb TheTweetOfGod APIKey APISecret ABC-123 1234567"
	raise "please retry with correct parameters"
end

twitter_handle = ARGV[0] || usage
@api_key = ARGV[1] || usage
@api_secret = ARGV[2] || usage
access_token = ARGV[3] || usage
access_secret = ARGV[4] || usage

# Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(@api_key, @api_secret, { :site => "https://api.twitter.com", :scheme => :header })

    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

    return access_token
end

# Exchange our oauth_token and oauth_token secret for the AccessToken instance.
access_token = prepare_access_token(access_token, access_secret)

# use the access token as an agent to get the home timeline
i = 0
max_tweet = "999000000000000000" #arbitrarilly large value since we're running oldest to youngest
keep_going = true
while (keep_going) do
  response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{twitter_handle}&count=200&max_id=#{max_tweet}")
  File.open("#{twitter_handle}_#{i}.json", 'w') { |file| file.write(response.body)}
  max_tweet = JSON.parse(response.body).last['id']
  # for debugging puts max_tweet
  i += 1
  if JSON.parse(response.body).size == 1
  	keep_going = false
  end
end