# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :current_user, only: %i[create]
  before_action :set_project, only: %i[create]

  def create
    message_body = message_params.fetch(:body, nil)

    if message_params.include?(:status)
      @project.update!(message_params)
      message_body = "Status changed to #{message_params.fetch(:status, nil)}"
    end

    @comment = @user.comments.build(body: message_body, user: @user)

    if @comment.save
      flash[:notice] = "Comment '#{message_body}' successfully sent."
    else
      flash[:alert] = 'Comment cannot be empty.'
    end
    redirect_to project_path(@project)
  end

  private

  def message_params
    return params.require(:comment).permit(:body) unless params[:project]

    params.require(:project).permit(:status)
  end

  def current_user
    @user = User.first
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  rescue_from ActiveRecord::RecordInvalid, with: :not_activated

  def not_activated
    flash[:alert] = 'Invalid status'
    redirect_to project_path(@project)
  end
end
