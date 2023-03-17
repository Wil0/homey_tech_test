# frozen_string_literal: true

RSpec.describe 'projects/index', type: :view do
  before(:each) do
    assign(:projects, [
             Project.create!(
               title: 'Project Y',
               description: 'A new Secret Project',
               status: Project::STATUSES.first
             ),
             Project.create!(
               title: 'Project Z',
               description: 'Top Secret',
               status: Project::STATUSES.first
             )
           ])
  end

  it 'renders a list of projects' do
    render

    expect(rendered).to match(/Projects/)
    expect(rendered).to include('Project Y')
    expect(rendered).to include('Project Z')
    expect(rendered).to include('Description: A new Secret Project')
    expect(rendered).to include('Description: Top Secret')
  end
end
