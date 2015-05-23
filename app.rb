require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'
require 'mongo'


class DatamuncherApp < Sinatra::Application

  # load config file
  register Sinatra::ConfigFile
  config_file 'config.yml'

  mongo = Mongo::Client.new( [ '127.0.0.1:27017' ], database: 'datamuncher' )

  get '/' do
    json mongo.database.collection_names
  end

  get '/spit/:collection' do
    collection = params[ :collection ]

    if collection
      mongo[ collection ].find.limit( 4000 ).sort( date: -1 ).map{ |c| { date: c[ :date ].iso8601, value: c[ :value ] } }.to_json
    else
      status 404
    end
  end

  post '/chew/:collection' do
    payload    = JSON.parse request.body.read
    collection = params[ :collection ]
    value      = payload[ 'value' ]
    date       = payload[ 'date' ]

    unless collection.is_a? String
      collection = nil
    end

    unless value.is_a?( Fixnum ) || value.is_a?( Float )
      value = nil
    end

    unless date.is_a? String
      date = Time.now
    else
      date = DateTime.iso8601( date )

      unless date.is_a? DateTime
        date = Time.now
      end
    end

    if collection && value
      data   = { value: value, date: date }

      exists =  mongo[ collection.to_sym ].find( date: date )

      if exists.count == 0
        result = mongo[ collection.to_sym ].insert_one( data )

        if result.successful?
          json data
        else
          status 500
        end
      else
        status 409
      end
    else
      status 422
    end
  end

  delete '/vom/:collection' do
    collection = params[ :collection ]

    if collection
      result = mongo[ collection ].drop

      if result.successful?
        status 204
      else
        status 500
      end
    else
      status 404
    end
  end

  not_found do
    status 404
  end

end
