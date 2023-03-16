# frozen_string_literal: true

RSpec.describe 'Projects', type: :request do
  let!(:project) { Project.first }

  describe 'GET /projects' do
    it 'shows all projects' do
      get '/projects'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Projects')
      expect(response.body).to include(project.title)
      expect(response.body).to include(project.description)
    end
  end

  describe 'GET /project' do
    it 'shows all projects' do
      get "/projects/#{project.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(project.title)
      expect(response.body).to include(project.description)
      expect(response.body).to include(project.comments.first.body)
      expect(response.body).to include('Send Comment')
    end
  end
end
