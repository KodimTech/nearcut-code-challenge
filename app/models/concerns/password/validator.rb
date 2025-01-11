module Password
  module Validator
    extend ActiveSupport::Concern

    PASSWORD_MIN_LENGTH = 10
    PASSWORD_MAX_LENGTH = 16

    included do
      before_validation :has_valid_length?
      before_validation :has_lowercase_char?
      before_validation :has_upcase_char?
      before_validation :has_consecutive_chars?
      before_validation :has_digits?
    end

    private

    def has_valid_length?
      errors.add(
        :password,
        "must be between #{PASSWORD_MIN_LENGTH} and #{PASSWORD_MAX_LENGTH} characters"
      ) unless (PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH).include?(password.length)
    end

    def has_lowercase_char?
      errors.add(:password, "must include at least one lowercase character") unless password.match?(/[a-z]/)
    end

    def has_upcase_char?
      errors.add(:password, "must include at least one uppercase character") unless password.match?(/[A-Z]/)
    end

    def has_consecutive_chars?
      cleaned_password = password.gsub(/[^a-zA-Z]/, " ")
      errors.add(:password, "must not include consecutive characters") if cleaned_password.match?(/([a-zA-Z])\1{2}/i)
    end

    def has_digits?
      errors.add(:password, "must include at least one digit") unless password.match?(/\d/)
    end
  end
end
