# frozen_string_literal: true

RSpec.describe 'Comments', type: :request do
  let(:project) { Project.first }

  describe 'POST /comment' do
    context 'valid params' do
      context 'the user adds a comment' do
        let(:comment_params) { { comment: { body: 'I will do this' } } }

        it 'shows a successfully created comment' do
          comment_create = "/projects/#{project.id}/comments"

          expect do
            post comment_create, params: comment_params
          end.to change(Comment, :count).by(1)

          expect(response).to redirect_to(project_path(project))
          expect(flash[:notice]).to eq 'Comment successfully sent.'
        end
      end

      context 'the user changes the status' do
        let(:comment_params) { { project: { status: 'In Progress' } } }
        it 'shows a successfully created comment' do
          comment_create = "/projects/#{project.id}/comments"

          expect do
            post comment_create, params: comment_params
          end.to change(Comment, :count).by(1)

          expect(response).to redirect_to(project_path(project))
          expect(flash[:notice]).to eq 'Comment successfully sent.'
        end
      end
    end

    context 'invalid params' do
      context 'empty comment body' do
        it 'shows an error created comment' do
          comment_create = "/projects/#{project.id}/comments"

          expect do
            post comment_create, params: { comment: { body: '' } }
          end.not_to change(Comment, :count)

          expect(response).to redirect_to(project_path(project))
          expect(flash[:alert]).to eq 'Your message has not beeen sent, please contact support.'
        end
      end

      context 'status is not in the list' do
        it 'shows an error created comment' do
          comment_create = "/projects/#{project.id}/comments"

          expect do
            post comment_create, params: { project: { status: 'Not in the list' } }
          end.not_to change(Comment, :count)

          expect(response).to redirect_to(project_path(project))
          expect(flash[:alert]).to eq 'Your message has not beeen sent, please contact support.'
        end
      end
    end
  end
end
