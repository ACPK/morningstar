# TODO: Don't yet know how the code below that's used for Yodlee will be similar to ByAllAccounts. Need to see what data is given when I first log in to Morningstar.
module Morningstar
  class Base
    include HTTParty

    cattr_accessor :current_session_token, :current_session_started

    def cobrand_token
      fresh_token? ? current_session_token : login_app
    end

    def query opts
      method   = opts[:method].to_s.downcase
      response = self.class.send(method, opts[:endpoint], query: opts[:params], headers: opts[:headers])
      data     = response.parsed_response

      log_query(opts.merge({response: data, code: response.code}))

      if response.success?
        if [ TrueClass, FalseClass, Fixnum ].include?(data.class)
          data
        else
          convert_to_mash(data)
        end
      else
        nil
      end
    end

    private

    def convert_to_mash data
      if data.is_a? Hash
        Hashie::Mash.new(data)
      elsif data.is_a? Array
        data.map { |d| Hashie::Mash.new(d) }
      end
    end

    def login_app
      response = query({
        :endpoint => '',
        :method => :POST,
        :params => {
          :cobrandLogin => Morningstar::Config.username,
          :cobrandPassword => Morningstar::Config.password
        }
      })

      self.current_session_started = Time.zone.now
      self.current_session_token = response.session.cobSession
    end

    def fresh_token?
      current_session_token && current_session_started && current_session_started >= 90.minutes.ago
    end

  end
end
