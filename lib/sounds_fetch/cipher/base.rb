module SoundsFetch
  module Cipher
    module Base
      extend ActiveSupport::Concern
      include ::SoundsFetch::Cipher::AesCbc

      BASE_KEY = nil

      class_methods do
        def encode(data)
          token = ::SoundsFetch::Cipher::AesCbc.encrypt(self::BASE_KEY ,data)
          CGI.escape(token)
        end

        def decode(token)
          ::SoundsFetch::Cipher::AesCbc.decrypt(self::BASE_KEY ,token)
        end

        private

        def unescaped_token(token)
          CGI.unescape(token)
        end
      end
    end
  end
end
