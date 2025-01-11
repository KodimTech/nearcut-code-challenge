require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'database' do
    describe 'notn null constraints' do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:password_digest).of_type(:string).with_options(null: false) }
    end
  end

  describe 'modules' do
    it 'includes has_secure_password' do
      expect(User.ancestors).to include(ActiveModel::SecurePassword)
    end
  end
end
