# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :current_user, only: %i[create]
  before_action :set_project, only: %i[create]

  def create
    message_body = message_params.fetch(:body, nil)
    @comment = @user.comments.build(body: message_body, user: @user)

    if @comment.save
      flash[:notice] = "Comment '#{message_body}' successfully sent."
    else
      flash[:alert] = 'Comment cannot be empty.'
    end
    redirect_to project_comments_path(@project)
  end

  def message_params
    params.require(:comment).permit(:body)
  end

  def current_user
    @user = User.first
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
