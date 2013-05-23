# encoding: utf-8

require File.dirname(__FILE__) + '/../integration_helper'
require 'locomotive/wagon/server'
require 'rack/test'

describe Locomotive::Wagon::Server do

  include Rack::Test::Methods

  def app
    run_server
  end
  
  it "converts {{ page.templatized? }} => true on templatized page" do
    get '/songs/song-1'
    last_response.body.should =~ /templatized=.true./
  end
  
  it "converts {{ page.templatized? }} => false on regular page" do
    get '/index'
    last_response.body.should =~ /templatized=.false./
  end

  it "converts {{ page.listed? }} => true on listed page" do
    get '/music'
    last_response.body.should =~ /listed=.true./
  end
  
  it "provides an access to page's content_type collection" do
    get '/songs/song-1'
    last_response.body.should =~ /content_type_size=.8./
  end
end