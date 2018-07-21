require "spec_helper"

RSpec.describe ApiV1::Views::ApplicationLayout, type: :view do
  let(:layout)   { ApiV1::Views::ApplicationLayout.new(template, {}) }
  let(:rendered) { layout.render }
  let(:template) { Hanami::View::Template.new('apps/api_v1/templates/application.html.erb') }

  it 'contains application name' do
    expect(rendered).to include('ApiV1')
  end
end
