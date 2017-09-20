require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'DB table' do
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :email }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'mailboxer' do
    let(:sender) {build(:user, name: 'sender') }
    let(:receiver) {build(:user, name: 'receiver')}

    before do
      sender.send_message(receiver, "body", "subject")
    end

    it 'creates a user with valid info' do
      expect(sender).to be_valid
    end

    describe 'send message' do
      it 'should be a new message in the Recievers inbox' do
        expect(receiver.mailbox.inbox.count).to eq 1
      end

      it 'should be a new message in the Senders outbox' do
        expect(sender.mailbox.sentbox.count).to eq 1
      end

      it 'should have a subject' do
        expect(receiver.mailbox.inbox.last.subject).to eq "subject"
      end

      it 'should have a text body' do
        conversation = receiver.mailbox.inbox.first
        receipts = conversation.receipts_for receiver
        message = receipts.first.message
        expect(message.body).to eq "body"
      end
    end

    describe 'reply to message' do

      before do
        conversation = receiver.mailbox.inbox.first
        receiver.reply_to_conversation(conversation, "reply body")
      end

      it 'should be a new message in Senders inbox' do
        expect(sender.mailbox.inbox.count).to eq 1
      end

      it 'should be a new message in Receivers outbox' do
        expect(receiver.mailbox.sentbox.count).to eq 1
      end

      it 'should have the same subject as earlier' do
        expect(sender.mailbox.inbox.last.subject).to eq "subject"
      end
    end

    describe 'delete message' do

      before(:each) do
        @conversation = receiver.mailbox.inbox.first
        @receipts = @conversation.receipts_for receiver
      end

      it 'user is able to delete receipt' do
        @receipts[0].mark_as_deleted
        expect(@receipts[0].deleted).to eq true
      end

      it 'user is able to delete conversation' do
        @conversation.mark_as_deleted receiver
        expect(receiver.mailbox.inbox.count).to eq 0
      end
    end
  end
end


