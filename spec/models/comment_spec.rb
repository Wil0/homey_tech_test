# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  let(:comment) { Comment.first }
  let(:user) { User.first }

  describe 'validations' do
    context 'comment does not exist' do
      it 'creates the Comment' do
        new_comment = Comment.new(body: 'A comment', user:)
        expect(new_comment).to be_valid
        expect { new_comment.save! }.to change(Comment, :count).by(1)
      end
    end

    context 'comment has no body' do
      it 'does not create the Comment with the same first name and last name' do
        new_comment = Comment.new(user:)
        new_comment.valid?
        expect(new_comment.errors.messages).to eq({ body: ["can't be blank"] })
      end
    end

    context 'comment has no user' do
      it 'creates the Comment' do
        new_comment = Comment.new(body: 'A comment')
        new_comment.valid?
        expect(new_comment.errors.messages).to eq({ user: ['must exist'] })
      end
    end
  end
end
