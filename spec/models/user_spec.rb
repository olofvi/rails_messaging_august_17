require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'DB table' do
    it {is_expected.to have_db_column :name}
    it {is_expected.to have_db_column :id}
    it {is_expected.to have_db_column :email}
  end

  describe 'Validations' do
    it {is_expected.to validate_presence_of :name}
  end

  describe 'mailboxer' do
    let(:sender) {build(:user, name: 'sender')}
    let(:receiver) {build(:user, name: 'receiver')}
    let(:conversation) {receiver.mailbox.inbox.first}
    let(:receipts) {conversation.receipts_for receiver}

    before do
      sender.send_message(receiver, 'body', 'subject')
    end

    it 'has a mailboxer name' do
      expect(User.last.mailboxer_name).to eq 'receiver'
    end

    it 'has a mailboxer email' do
      expect(User.last.mailboxer_email(0)).to eq 'receiver@test.com'
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
        expect(receiver.mailbox.inbox.last.subject).to eq 'subject'
      end

      it 'should have a text body' do
        message = receipts.first.message
        expect(message.body).to eq 'body'
      end
    end

    describe 'reply to message' do

      before do
        receiver.reply_to_conversation(conversation, 'reply body')
      end

      it 'should be a new message in Senders inbox' do
        expect(sender.mailbox.inbox.count).to eq 1
      end

      it 'should be a new message in Receivers outbox' do
        expect(receiver.mailbox.sentbox.count).to eq 1
      end

      it 'should have the same subject as earlier' do
        expect(sender.mailbox.inbox.last.subject).to eq 'subject'
      end
    end

    describe 'delete message' do

      it 'user is able to delete receipt' do
        receipts[0].mark_as_deleted
        expect(receipts[0].deleted).to eq true
      end

      it 'user is able to delete conversation' do
        conversation.mark_as_deleted receiver
        expect(receiver.mailbox.inbox.count).to eq 0
      end
    end
  end
end


