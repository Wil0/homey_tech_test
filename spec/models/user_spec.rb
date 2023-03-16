# frozen_string_literal: true

RSpec.describe User, type: :model do
  let(:user) { User.first }

  describe 'validations' do
    context 'user does not exist' do
      it 'creates the user' do
        new_user = User.new(first_name: 'New', last_name: 'User')
        expect(new_user).to be_valid
        expect { new_user.save! }.to change(User, :count).by(1)
      end
    end

    context 'user already exists' do
      it 'does not create the user with the same first name and last name' do
        new_user = User.new(first_name: user.first_name, last_name: user.last_name)
        expect(new_user).to_not be_valid
        expect(new_user.errors.messages).to eq({ first_name: ['has already been taken'],
                                                 last_name: ['has already been taken'] })
      end
    end
  end

  describe '.full_name' do
    it 'returns full name of the user' do
      expect(user.full_name).to eq('Jon Bovi')
    end
  end
end
