# frozen_string_literal: true

RSpec.describe 'Comments', type: :request do
  let(:project) { Project.first }

  describe 'POST /comment' do
    let(:comment_params) { { comment: { body: 'I will do this' } } }

    context 'valid params' do
      it 'shows a successfully created comment' do
        comment_create = "/projects/#{project.id}/comments"

        expect do
          post comment_create, params: comment_params
        end.to change(Comment, :count).by(1)

        expect(response).to redirect_to(project_comments_path)
        expect(flash[:notice]).to eq "Comment 'I will do this' successfully sent."
      end
    end

    context 'valid params' do
      it 'shows an error created comment' do
        comment_create = "/projects/#{project.id}/comments"

        expect do
          post comment_create, params: { comment: { body: '' } }
        end.not_to change(Comment, :count)

        expect(response).to redirect_to(project_comments_path)
        expect(flash[:alert]).to eq 'Comment cannot be empty.'
      end
    end
  end
end
