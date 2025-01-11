module Password
  module Validator
    extend ActiveSupport::Concern

    MIN_LENGTH = 10
    MAX_LENGTH = 16

    included do
      before_validation :valid_length?
      before_validation :valid_lowercase?
      before_validation :valid_upcase?
      before_validation :has_consecutive_chars?
    end

    private

    def valid_length?
      errors.add(
        :password,
        "must be between #{MIN_LENGTH} and #{MAX_LENGTH} characters"
      ) unless (MIN_LENGTH..MAX_LENGTH).include?(password.length)
    end

    def valid_lowercase?
      errors.add(:password, "must include at least one lowercase character") unless password.match?(/[a-z]/)
    end

    def valid_upcase?
      errors.add(:password, "must include at least one uppercase character") unless password.match?(/[A-Z]/)
    end

    def has_consecutive_chars?
      errors.add(:password, "must not include consecutive characters") if password.match?(/(.)\1\1/i)
    end
  end
end
