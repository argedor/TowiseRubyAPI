require "towise/version"
require "faraday"
require 'json'

module Towise
  class API
    attr_accessor :headers, :BASE_URL, :DETECT, :RECOGNIZE, :PERSONS, :FACES
      def initialize(config)
          config['Content-Type'] = 'application/x-www-form-urlencoded'
          @headers = config
          @BASE_URL = "https://api.towise.io"
          @DETECT = {
              "face" => "/detect/face",
              "body" => "/detect/person",
              "emotion" => "/detect/emotion"
          }
          @RECOGNIZE = {
              "face" => "/recognize/face" 
          }
          @PERSONS = "/persons/"
          @FACES = "/faces/"  

      end

      def checkImage?(image)
          isBase64 = !!image.match(/(data:image\/jpeg;base63)/)
          if(isBase64)
              return { "image_base64" => image}
          else
              return {"image_url" => image}
          end
      end
      
      def faceDetect(image=nil)
          
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end
          response = conn.post(@DETECT['face'],checkImage?(image))
          return JSON.parse(response.body)
      end

      def bodyDetect(image=nil)
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end

          response = conn.post(@DETECT['body'],checkImage?(image))
          return JSON.parse(response.body)
      end

      def emotionDetect(image=nil)
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end
          response = conn.post(@DETECT['emotion'],checkImage?(image))
          return JSON.parse(response.body)
      end

      def faceComparing(image=nil)
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end
          response = conn.post(@RECOGNIZE['face'],checkImage?(image))
          return JSON.parse(response.body)
      end

      def getAllPerson()
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.adapter Faraday.default_adapter
          end
          response = conn.get(@PERSONS)
          return JSON.parse(response.body)
      end

      def getPerson(personId)
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.params['person_id'] = personId
              f.adapter Faraday.default_adapter
          end
          response = conn.get(@PERSONS)
          return JSON.parse(response.body)
      end

      def addPerson(name)
          data = {
              "name" => name
          }
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end
          response = conn.post(@PERSONS,data)
          return JSON.parse(response.body)
      end

      def removePerson(personId)
          data =  {
              "person_id":personId
          }
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end
          response = conn.run_request(:delete,@PERSONS,data,@headers)
          return JSON.parse(response.body)
      end

      def getAllFace(personId)
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.params['person_id'] = personId
              f.adapter Faraday.default_adapter
          end
          response = conn.get(@FACES)
          return JSON.parse(response.body)
      end

      def getFace(faceId)
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.params['face_id'] = faceId
              f.adapter Faraday.default_adapter
          end
          response = conn.get(@FACES)
          return JSON.parse(response.body)
      end

      def addFace(image, personId,imageSave="no")
          data = checkImage?(image)
          data['person_id'] = personId
          data['save_image'] = imageSave
          
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.headers = @headers
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end
          response = conn.post(@FACES,data)
          return JSON.parse(response.body)
      end

      def removeFace(faceId)
          data = {
              "face_id" => faceId
          }
          conn = Faraday.new(:url => @BASE_URL) do |f|
              f.request :url_encoded
              f.adapter Faraday.default_adapter
          end
          response = conn.run_request(:delete,@FACES,data,@headers)
          return JSON.parse(response.body)
      end
    end
end
