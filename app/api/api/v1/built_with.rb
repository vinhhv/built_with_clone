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
          return 201
        end
      end

    end
  end
end
