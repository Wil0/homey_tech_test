# frozen_string_literal: true

RSpec.describe Project, type: :model do
  let(:project) { Project.first }

  describe 'relationships' do
    let(:user) { User.first }

    describe 'users' do
      it 'can have many users' do
        expect(project.users).to include(user)
      end

      it 'does not have duplicated users' do
        expect { project.users << user }.to_not change(project.users, :count)
      end
    end

    describe 'comments' do
      it 'can have many users' do
        user = User.first
        comment = Comment.create(body: 'New comment', user:)

        expect(project.comments).to include(comment)
      end
    end
  end
  describe 'validations' do
    context 'project does not exist' do
      it 'creates the Project' do
        new_project = Project.new(title: 'A project', status: 'To Do')

        expect(new_project).to be_valid
        expect { new_project.save! }.to change(Project, :count).by(1)
      end
    end

    context 'project already exists' do
      it 'does not create the Project' do
        new_project = Project.new(title: project.title)

        expect(new_project).not_to be_valid
      end
    end

    context 'project has no title' do
      it 'does not create the Project with the same first name and last name' do
        new_project = Project.new(status: 'To Do')

        expect(new_project).not_to be_valid
        expect(new_project.errors.messages).to eq({ title: ["can't be blank"] })
      end
    end

    context 'project has no status' do
      it 'does not create the Project with the same first name and last name' do
        new_project = Project.new(title: 'A project')

        expect(new_project).not_to be_valid
        expect(new_project.errors.messages[:status]).to include("can't be blank")
      end
    end

    context 'project has only accepeted status' do
      it 'does not create the Project with the same first name and last name' do
        new_project = Project.new(title: 'A project', status: 'Invalid')

        expect(new_project).not_to be_valid
        expect(new_project.errors.messages).to eq({ status: ['is not included in the list'] })
      end
    end
  end
end
