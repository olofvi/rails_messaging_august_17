require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'DB table' do
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :email }
  end

  describe 'mailboxer' do
    let (:sender) { User.create(email: 'sender@test.com', password: 'password', name: 'sender') }
    let (:receiver) { User.create(email: 'receiver@test.com', password: 'password', name: 'receiver') }

    it 'creates a user with valid info' do
      expect(sender).to be_valid
    end

    describe 'send message' do

      before do
        sender.send_message(receiver, "body", "subject")
      end

      it 'should be a new message in the recievers inbox' do
        expect(receiver.mailbox.inbox.count).to eq 1
      end

      it 'should be a new message in the senders outbox' do
        expect(sender.mailbox.sentbox.count).to eq 1
      end

      it 'should have a subject' do
        expect(receiver.mailbox.inbox.last.subject).to eq "subject"
      end

      it 'should have a text body' do
        conversation = receiver.mailbox.inbox.first
        receipts = conversation.receipts_for receiver
        receipts.each do |receipt|
          @message = receipt.message
        end
        expect(@message.body).to eq "body"
      end
    end
  end
end
