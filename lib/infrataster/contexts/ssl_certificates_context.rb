require 'infrataster'
require 'net/https'

module Infrataster
  module Contexts
    class SslCertificatesContext < BaseContext
      def certificate
        options = { port: 443,
                    open_timeout: nil,
                    read_timeout: 60 }

        if server.options[:ssl]
          options = options.merge(server.options[:ssl])
        end

        if server.options[:open_timeout]
          options = options.merge(server.options[:open_timeout])
        end

        if server.options[:read_timeout]
          options = options.merge(server.options[:read_timeout])
        end

        https = Net::HTTP.new(resource.domain, options[:port])
        https.use_ssl = true
        https.open_timeout = options[:open_timeout]
        https.read_timeout = options[:read_timeout]
        https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        https.start do
          https.peer_cert
        end
      end
    end
  end
end
