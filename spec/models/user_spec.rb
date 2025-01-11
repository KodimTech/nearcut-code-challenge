require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

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

    it 'includes Password::Validator' do
      expect(User.ancestors).to include(Password::Validator)
    end
  end

  describe 'validations' do
    describe 'before_validation' do
      describe '#valid_length?' do
        context 'when password doesn\'t meet minimum or maximum length' do
          it 'adds an error to the password attribute' do
            user.password = SecureRandom.hex(4)
            user.valid?

            expect(user.errors[:password]).to include('must be between 10 and 16 characters')
          end
        end
      end

      describe '#valid_lowercase?' do
        context 'when password doesn\'t include a lowercase character' do
          it 'adds an error to the password attribute' do
            user.password = SecureRandom.hex(5).upcase
            user.valid?

            expect(user.errors[:password]).to include('must include at least one lowercase character')
          end
        end
      end

      describe '#valid_upcase?' do
        context 'when password doesn\'t include an uppercase character' do
          it 'adds an error to the password attribute' do
            user.password = SecureRandom.hex(5).downcase
            user.valid?

            expect(user.errors[:password]).to include('must include at least one uppercase character')
          end
        end
      end

      describe '#has_consecutive_chars?' do
        context 'when password includes consecutive characters' do
          it 'adds an error to the password attribute' do
            user.password = SecureRandom.hex(5) + 'AaA'
            user.valid?

            expect(user.errors[:password]).to include('must not include consecutive characters')
          end
        end
      end
    end
  end
end
