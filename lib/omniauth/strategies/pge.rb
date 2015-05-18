require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class PGE < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://api.pge.com',
        authorize_url: 'https://api.pge.com/datacustodian/test/oauth/v2/authorize',
        token_url: 'https://api.pge.com/datacustodian/test/oauth/v2/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
      end
    end
  end
end

OmniAuth.config.add_camelization 'pge', 'PGE'
