module Password
  module Validator
    extend ActiveSupport::Concern

    MIN_LENGTH = 10
    MAX_LENGTH = 16

    included do
      before_validation :valid_length?
    end

    private

    def valid_length?
      errors.add(
        :password,
        "must be between #{MIN_LENGTH} and #{MAX_LENGTH} characters"
      ) unless (MIN_LENGTH..MAX_LENGTH).include?(password.length)
    end
  end
end
