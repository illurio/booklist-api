class ApplicationController < ActionController::Base

  require 'net/http'
  require 'json'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def parseData (uri)
    uri = URI.parse(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return response
    office = response.body
    if response.header["Content-Encoding"] == "gzip"
      gz = Zlib::GzipReader.new(StringIO.new(office.to_s))    
      office = gz.read
    end
    office
  end


  def getFictionList
  	render json: parseData('http://api.nytimes.com/svc/books/v2/lists/Combined-Print-and-E-Book-Fiction.json?api-key=sample-key').body
  end
  def getNonFictionList
  	render json: parseData('http://api.nytimes.com/svc/books/v2/lists/Combined-Print-and-E-Book-NonFiction.json?api-key=sample-key').body
  end
  def getYoungAdultList
  	render json: parseData('http://api.nytimes.com/svc/books/v2/lists/young-adult.json?api-key=sample-key').body
  end
  def getPictureBookList
  	render json: parseData('http://api.nytimes.com/svc/books/v2/lists/picture-book.json?api-key=sample-key').body
  end
end
