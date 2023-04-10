# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload)
    exp = 1.hour.from_now.to_i
    JWT.encode(payload, 'secrets', 'HS256', exp: exp)
  end

  def self.decode(token)
    JWT.decode(token, 'secrets', true, {algorithm: 'HS256'})[0]
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    raise JWT::ExpiredSignature, e.message
  rescue JWT::DecodeError, JWT::VerificationError => e
    raise JWT::DecodeError, e.message
  end
end