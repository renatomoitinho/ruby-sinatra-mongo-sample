# sina.rb
require 'sinatra'
require 'mongo'
require 'json/ext'

include Mongo

configure do
 conn = MongoClient.new("localhost",27017)
 set:mongo_connection, conn
 set:mongo_db,conn.db("test")
end
  

#helpers

helpers do
  # a helper method to turn a string ID
  # representation into a BSON::ObjectId
  def object_id val
    BSON::ObjectId.from_string(val)
  end

  def document_by_id id
    id = object_id(id) if String === id
    settings.mongo_db['users'].
      find_one(:_id => id).to_json
  end
end

#end helpers
#lambda fibonacci
f = ->(x){ x < 2 ? x : f[x-1] + f[x-2] }

get '/collections/?' do
 content_type:json
 settings.mongo_db.collection_names.to_json
end

get '/documents/?' do
  content_type :json
  settings.mongo_db['users'].find.to_a.to_json
end

# find a document by its ID
get '/document/:id/?' do
  content_type :json
  document_by_id(params[:id])
end

get '/fib/:val' do
 "#{ f[ params[:val].to_i ] }"  
end
 
