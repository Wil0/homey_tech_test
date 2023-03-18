# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :current_user, only: %i[create]
  before_action :set_project, only: %i[create]

  def create
    @comment = CommentCreateService.new(@project, @user, message_params).run
    flash[:notice] = 'Comment successfully sent.'
    redirect_to project_path(@project)
  rescue ProjectNotUpdatedError, NoCommentBodyError
    flash[:alert] = 'Your message has not beeen sent, please contact support.'
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
end
