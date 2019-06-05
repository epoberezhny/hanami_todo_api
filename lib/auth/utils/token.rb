module Auth
  module Utils
    module Token
      def self.generate_tokens(user)
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_payload: payload)
        session.login
      end

      def self.refresh_tokens(refresh_token, payload)
        session = JWTSessions::Session.new(payload: payload, refresh_payload: payload)
        session.refresh(refresh_token)
      end

      def self.flush_session(refres_token)
        session = JWTSessions::Session.new
        session.flush_by_token(refres_token)
      end
    end
  end
end
