module SoundsFetch
  module Cipher
    module AesCbc
      BASE_SALT = "\x00\x01\x02\x03\x04\x05\x06\x07"
      ALGORITHM = 'AES-128-CBC'
      IV = 65156
      COUNT = 16

      class << self
        def encrypt(key_base, data)
          cipher = cipher_instance
          cipher.encrypt
          cipher.key = initialization_vector(key_base)
          iv = cipher.random_iv
          encrypted = cipher.update(data) + cipher.final

          cryptography = Base64.encode64 iv + encrypted
        end

        def decrypt(key_base, cryptography)
          decoded = Base64.decode64 cryptography
          iv = decoded[0..15]
          encrypted = decoded[16..-1]

          cipher = cipher_instance
          cipher.decrypt
          cipher.key = initialization_vector(key_base)
          cipher.iv = iv

          data = cipher.update(encrypted) + cipher.final
        end

        private

        def cipher_instance
          OpenSSL::Cipher.new(ALGORITHM)
        end

        def initialization_vector(key_base)
          OpenSSL::PKCS5.pbkdf2_hmac_sha1(key_base, BASE_SALT, IV, COUNT)
        end
      end
    end
  end
end
