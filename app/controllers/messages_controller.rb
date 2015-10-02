class MessagesController < ApplicationController
	before_filter :current_user
	before_filter :require_login

	def index
    @current_user = current_user
		@inbox_messages = Message.inbox_messages(@current_user)
    @sent_messages = @current_user.messages.order("created_at DESC")
	end

  def create
    @reply = Message.new
    @current_user = current_user
    @receiver = User.find_by(:slug => message_params[:receiver])
    @message = @current_user.messages.new(message_params)
    @message.receiver_id = @receiver.id
    @message.reply = @message.generate_token

    if @message.save
      respond_to do |format|
        format.js
      end
    else
      flash.now[:alert] = "We're sorry, but we weren't able to send your message."
    end
  end

  def show
    @current_user = current_user
    @reply = Message.new
    @message = Message.find(params[:id])

    # Mark as read
    if !@message.read
      @message.update_column(:read, true)
    end

    if !@message.nil?
      respond_to do |format|
        format.js
      end
    else
      flash.now[:alert] = "This message is no longer in our database."
    end
  end

  def reply
    @current_user = current_user
    @reply = Message.new(message_params)
    @reply.reply = message_params[:thread]
    latest_message = @reply.latest_message(message_params[:thread])
    @reply.subject = "RE: #{latest_message.subject}"

    # Switch the sender and receiver
    @reply.user_id = @current_user.id
    
    if latest_message.receiver_id == @current_user.id
      @reply.receiver_id = latest_message.user_id
    else
      @reply.receiver_id = latest_message.receiver_id
    end
    
    if @reply.save
      respond_to do |format|
        format.js { render :action => "reply" }
      end
    else
      flash.now[:alert] = "We're sorry, but we weren't able to process your reply right now."
    end
  end

  private
  def message_params
    params.require(:message).permit(:receiver, :subject, :body, :stem, :thread)
  end
end
