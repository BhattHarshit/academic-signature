# frozen_string_literal: true

# Local-development log cleanup for Jekyll's WEBrick server.
#
# Browsers can close LiveReload sockets while WEBrick is reading them, and PDF
# viewers can retry byte-range requests after a rebuild. WEBrick logs those two
# normal client behaviours at ERROR level even though the site is healthy.
# Suppress only those known transport messages in development; all other
# WEBrick/Jekyll errors remain untouched. Production builds are never patched.

return unless ARGV.include?('serve')
return if ENV.fetch('JEKYLL_ENV', 'development') == 'production'

require 'webrick'

module AcademicSignature
  module QuietLocalWebrickNoise
    BENIGN_MESSAGES = [
      'Errno::ECONNRESET',
      'Connection reset by peer',
      'WEBrick::HTTPStatus::RequestRangeNotSatisfiable'
    ].freeze

    def log(level, data)
      text = if data.is_a?(Exception)
               "#{data.class}: #{data.message}"
             else
               data.to_s
             end

      return if BENIGN_MESSAGES.any? { |message| text.include?(message) }

      super
    end
  end
end

WEBrick::Log.prepend(AcademicSignature::QuietLocalWebrickNoise) unless WEBrick::Log < AcademicSignature::QuietLocalWebrickNoise
