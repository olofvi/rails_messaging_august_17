class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
    flash[:info] = 'Please fill out all the fields, then press Send Message'
  end

  def create
    recipients = User.where(id: conversation_params[:recipients])
    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
    if conversation
      flash[:success] = 'Your message was successfully sent!'
      redirect_to conversation_path(conversation)
    else
      flash[:warning] = 'You need to fill out all the fields'
      redirect_to mailbox_inbox_path
    end
  end

  def show
    @receipts = conversation.receipts_for(current_user)
    # mark conversation as read
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = 'Your reply message was successfully sent!'
    redirect_to conversation_path(conversation)
  end

  def trash
    flash[:alert] = 'Your message is now trashed'
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    flash[:info] = 'Your message is now untrashed'
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end

  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body, recipients: [])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end

end
