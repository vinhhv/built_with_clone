require 'json'
require 'net/http'
require 'uri'

module API
  module V1
    class BuiltWith < Grape::API
      include API::V1::Defaults

      resource :built_with do
        desc "Built with"
        params do
          requires :url, type: String, desc: 'URL'
        end
        get 'build_with' do
          unless params[:url] =~ URI::regexp
            return "Incorrect URL format"
          end
          uri = URI(params[:url])
          resp = {}
          resp['html'] = Net::HTTP.get(uri).force_encoding('ISO-8859-1').encode('UTF-8')
          if Net::HTTP.get_response(uri.host, '/robots.txt').class == Net::HTTPOK
            resp['has robot.txt'] = true
          else
            resp['has robot.txt'] = false
          end
          if resp['html'].include?('bootstrap.css')
            resp['uses bootstrap'] = true
          else
            resp['uses bootstrap'] = false
          end
          return resp
        end
      end

    end
  end
end
