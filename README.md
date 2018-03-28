# ruby-dropbox-api

Installation
------------

```
gem "shopify_api", git: 'https://github.com/pedro-bre/ruby-dropbox-api.git'
```

Getting started
---------------

### OAuth Flow

([https://www.dropbox.com/developers/reference/oauth-guide#oauth-2-on-the-web](https://www.dropbox.com/developers/reference/oauth-guide#oauth-2-on-the-web))

```ruby
web_auth = DropboxApi::Auth.new(CLIENT_ID, CLIENT_SECRET)
web_auth.authorize_url #=> "https://www.dropbox.com/..."

# Now you need to open the authorization URL in your browser,
# authorize the application, copy your code and exchange it for the access token.

access_token = web_auth.get_token(CODE) #=> FZiHb5TP...
```

### Performing API calls

First initialize the client using the access token:

```ruby
client = Dropbox::Client.new('FZiHb5TP...')
```
Then you can perform API calls like this:

```ruby
# list folder
list_folder = client.list_folder('/sample_folder') #=> <Dropbox::Response::ListFolder>
list_folder.entries #=> [<Dropbox::Metadata::File>, <Dropbox::Metadata::Folder>]
list_folder.has_more? #=> false
# upload file
client.get_metadata('/sample_file.txt') #=> <Dropbox::Metadata::File>
# preview file
client.get_preview('/sample_table.csv') do |file_metadata, file_preview|
  file_metadata #=> <Dropbox::Metadata::File>
  file_preview #=> String
end
```