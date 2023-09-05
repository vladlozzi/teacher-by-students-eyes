require 'rails_helper'

RSpec.describe "people/edit", type: :view do
  let(:person) {
    Person.create!(
      full_name: "MyString",
      email: "my.string@example.com"
    )
  }

  before(:each) do
    assign(:person, person)
  end

  it "renders the edit person form" do
    render

    assert_select "form[action=?][method=?]", person_path(person), "post" do

      assert_select "input[name=?]", "person[full_name]"

      assert_select "input[name=?]", "person[email]"
    end
  end
end
