require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'DB table' do
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :email }
  end

  describe 'mailboxer' do
    let (:sender) { User.create(email: 'sender@test.com', password: 'password', name: 'sender') }
    let (:reciever) { User.create(email: 'receiver@test.com', password: 'password', name: 'receiver') }

    it 'creates a user with valid info' do
      expect(sender).to be_valid
    end
  end

end
