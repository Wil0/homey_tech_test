# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :project, only: %i[show]
  before_action :current_user, only: %i[show]

  def index
    @projects = Project.page(params[:page]).order('created_at DESC')
  end

  def show
    @comment = @user.comments.build
    @comments = @project.comments.page(params[:page]).order('created_at DESC')
  end

  private

  def current_user
    @user = User.first
  end

  def project
    @project = Project.find(params[:id])
  end
end
