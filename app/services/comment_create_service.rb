# frozen_string_literal: true

class ProjectNotUpdatedError < StandardError; end

class NoCommentBodyError < StandardError; end

class CommentCreateService
  attr_reader :message_params

  def initialize(project, user, message_params)
    @project = project
    @user = user
    @message_params = message_params
    @errors = []
  end

  def run
    create
  end

  private

  def create
    message_body = message_params.fetch(:body, nil)

    if message_params.include?(:status)
      begin
        @project.update!(message_params)
        message_body = "Status changed to #{message_params.fetch(:status, nil)}"
      rescue  ActiveRecord::RecordInvalid
        raise ProjectNotUpdatedError
      end
    end

    begin
      @comment = @user.comments.create!(body: message_body, user: @user)
    rescue ActiveRecord::RecordInvalid
      raise NoCommentBodyError
    end
  end
end
