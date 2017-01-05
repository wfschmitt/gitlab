require 'gitlab'
require 'gitlab/cli'
require 'gitlab'
require 'gitlab/help'
require 'gitlab/shell'

require "pretty_inspect"
# set an API endpoint
Gitlab.endpoint = 'http://susi/api/v3'
# => "http://example.net/api/v3"

# set a user private token
Gitlab.private_token = 'vzc4neoiEX9q1EX1boUo'
# => "qEsq1pt6HJPaNciie3MG"

# configure a proxy server Gitlab.http_proxy('proxyhost', 8888)  # proxy server w/ basic auth Gitlab.http_proxy('proxyhost', 8888, 'proxyuser', 'strongpasswordhere')

# list projects
#p = Gitlab _search('werner')
#print p.pretty_inspect
# => [#<Gitlab::ObjectifiedHash:0x000000023326e0 @data={"id"=>1, "code"=>"brute", "name"=>"Brute", "description"=>nil, "path"=>"brute", "default_branch"=>nil, "owner"=>#<Gitlab::ObjectifiedHash:0x00000002331600 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>, "private"=>true, "issues_enabled"=>true, "merge_requests_enabled"=>true, "wall_enabled"=>true, "wiki_enabled"=>true, "created_at"=>"2012-09-17T09:41:56Z"}>, #<Gitlab::ObjectifiedHash:0x000000023450d8 @data={"id"=>2, "code"=>"mozart", "name"=>"Mozart", "description"=>nil, "path"=>"mozart", "default_branch"=>nil, "owner"=>#<Gitlab::ObjectifiedHash:0x00000002344ca0 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>, "private"=>true, "issues_enabled"=>true, "merge_requests_enabled"=>true, "wall_enabled"=>true, "wiki_enabled"=>true, "created_at"=>"2012-09-17T09:41:57Z"}>, #<Gitlab::ObjectifiedHash:0x00000002344958 @data={"id"=>3, "code"=>"gitlab", "name"=>"Gitlab", "description"=>nil, "path"=>"gitlab", "default_branch"=>nil, "owner"=>#<Gitlab::ObjectifiedHash:0x000000023447a0 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>, "private"=>true, "issues_enabled"=>true, "merge_requests_enabled"=>true, "wall_enabled"=>true, "wiki_enabled"=>true, "created_at"=>"2012-09-17T09:41:58Z"}>]
# initialize a new client
client = Gitlab.client(endpoint:  'http://susi/api/v3', private_token: 'vzc4neoiEX9q1EX1boUo')
# => #<Gitlab::Client:0x00000001e62408 @endpoint="https://api.example.com", @private_token="qEsq1pt6HJPaNciie3MG", @user_agent="Gitlab Ruby Gem 2.0.0">
puts "got client "
# get a user
projects = client.projects()  #{per_page: 200}) ##_search('werner',)
# => #<Gitlab::ObjectifiedHash:0x00000002217990 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "bio"=>nil, "skype"=>"", "linkedin"=>"", "twitter"=>"john", "dark_scheme"=>false, "theme_id"=>1, "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>
#print projects.pretty_inspect
projects.auto_paginate do |project|

#projects.each  do |project|
  
  
  next if project.namespace.name != 'werner'
  puts "---------------------------------------------------"
  puts project.namespace.name
  puts project.name
  test = client.project_search( "#{project.name}")
  found = false
  if ! test.nil?
    test.each do | t|
      if t.namespace.name=='github' and ! t.name == project.name
        found = true
      end
    end
  end

  
  if 'werner' == project.namespace.name and !found
    client.transfer_project_to_group(36,project.id)
    
  end
  #  # do something
end






# get a user's email
#user.email
# => "john@example.com"
#client.transfer_project_to_group(36,868)

#ransfer_#new(endpoint:  'http://susi/api/v3', private_token: 'vzc4neoiEX9q1EX1boUo')
#shell.setup
#shell.execute('transfer_project_to_group 36 858')
#shell.history

# set a sudo mode to perform API calls as another user
#Gitlab.sudo = 'other_user'
# => "other_user"
#
# disable a sudo mode
#Gitlab.sudo = nil
# => nil
#
# a paginated response
#projects = Gitlab.projects(per_page: 5)
#
# check existence of the next page
#projects.has_next_page?
#
# retrieve the next page
#projects.next_page
#
# iterate all projects
#projects.auto_paginate do |project|
#  # do something
#end
#
# retrieve all projects as an array
#projects.auto_paginate