# twitter-agitator-aggregator
A simple tool to search for the most commonly used words or phrases by a specified Twitter Handle

This project provides two ruby utilities that access the twitter API and track down the history of tweets from a user and aggrigate them to a simpler to read format.

## agitator.rb > requires an API key and OAuth token setup.
```
ruby agitator.rb <twitter_handle> <API_Key> <API_Secret> <AccessToken> <AccessSecret>
```
after running the command, a list of files with the twitter_handle_#.json will be generated in the current working directory.  You can then use those files with aggregator.rb

## aggregator.rb > only requires the files to be pre-generated (see examples)
```
ruby aggregator.rb realDonaldTrump 17 > trump_tweets.txt"
```
reads the twitter_handle and the number of files, and skims through the json for only the date and body of the tweet, ignoring the metadata.  This can be piped to another file or modified to do additional analysis as needed.