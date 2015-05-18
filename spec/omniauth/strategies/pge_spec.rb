require 'spec_helper'

module OmniAuth
  module Strategies
    describe PGE do
      let(:access_token)    { stub('AccessToken', options: {}) }
      let(:parsed_response) { stub('ParsedResponse') }
      let(:response)        { stub('Response', parsed: parsed_response) }

      let(:production_site)          { 'https://some.other.site.com/api/v3' }
      let(:production_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
      let(:production_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
      let(:production) do
        OmniAuth::Strategies::PGE.new('PGE_KEY', 'PGE_SECRET', {
          client_options: {
            site: production_site,
            authorize_url: production_authorize_url,
            token_url: production_token_url
          }
        })
      end

      subject do
        OmniAuth::Strategies::PGE.new({})
      end

      before(:each) do
        allow(subject).to receive(:access_token) { access_token }
      end

      context 'client options' do
        it 'should have correct site' do
          expect(subject.options.client_options.site).to eq 'https://api.pge.com'
        end

        it 'should have correct authorize url' do
          expect(subject.options.client_options.authorize_url).to eq 'https://api.pge.com/datacustodian/test/oauth/v2/authorize'
        end

        it 'should have correct token url' do
          expect(subject.options.client_options.token_url).to eq 'https://api.pge.com/datacustodian/test/oauth/v2/token'
        end

        describe 'should be overrideable' do
          it 'for site' do
            expect(production.options.client_options.site).to eq production_site
          end

          it 'for authorize url' do
            expect(production.options.client_options.authorize_url).to eq production_authorize_url
          end

          it 'for token url' do
            expect(production.options.client_options.token_url).to eq production_token_url
          end
        end
      end
    end
  end
end
