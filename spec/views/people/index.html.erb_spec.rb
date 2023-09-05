require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before(:each) do
    assign(:people, [
      Person.create!(
        full_name: "Full Name 1",
        email: "my.string1@example.com"
      ),
      Person.create!(
        full_name: "Full Name 2",
        email: "my.string2@example.com"
      )
    ])
  end

  it "renders a list of people" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Full Name 1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("my.string1@example.com".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Full Name 2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("my.string2@example.com".to_s), count: 1
  end
end
