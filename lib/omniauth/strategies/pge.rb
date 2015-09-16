require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class PGE < OmniAuth::Strategies::OAuth2
      def self.ssl_options
        {
          client_cert: OpenSSL::X509::Certificate.new(ENV.fetch("SSL_CERTIFICATE")),
          client_key: OpenSSL::PKey::RSA.new(ENV.fetch("SSL_PRIVATE_KEY")),
        }
      end

      def self.authorization_url
        ENV.fetch(
          "PGE_OAUTH_AUTHORIZATION_URL",
          "https://api.pge.com/datacustodian/test/oauth/v2/authorize",
        )
      end

      def self.token_url
        ENV.fetch(
          "PGE_OAUTH_TOKEN_URL",
          "https://api.pge.com/datacustodian/test/oauth/v2/token",
        )
      end

      option :client_options, {
        site: 'https://api.pge.com',
        authorize_url: authorization_url,
        token_url: token_url,
        connection_opts: { ssl: ssl_options }
      }

      def build_access_token
        options.token_params.merge!(
          headers: {
            "Authorization" => authorization_header,
            "Content-Type" => "text/plain",
          },
        )

        params_string = URI.encode_www_form(
          "code" => request.params["code"],
          "grant_type" => "authorization_code",
          "redirect_uri" => callback_url,
        )
        options.client_options[:token_url] += "?" + params_string

        super
      end

      def authorization_header
        credential_string = "#{options.client_id}:#{options.client_secret}"
        encoded_credentials = Base64.urlsafe_encode64(credential_string)
        "Basic #{encoded_credentials}"
      end

      info do
        access_token.to_hash
      end
    end
  end
end

module Faraday
  class Connection
    alias original_run_request run_request

    # Builds and runs the Faraday::Request.
    #
    # method  - The Symbol HTTP method.
    # url     - The String or URI to access.
    # body    - The String body
    # headers - Hash of unencoded HTTP header key/value pairs.
    #
    # Returns a Faraday::Response.
    def run_request(method, url, body, headers)
      original_run_request(method, url, "", headers)
    end
  end
end

OmniAuth.config.add_camelization 'pge', 'PGE'
