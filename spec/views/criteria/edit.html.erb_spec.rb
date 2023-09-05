require 'rails_helper'

RSpec.describe "criteria/edit", type: :view do
  let(:criterium) {
    Criterium.create!(
      name: "MyString",
      scale: "MyString"
    )
  }

  before(:each) do
    assign(:criterium, criterium)
  end

  it "renders the edit criterium form" do
    render

    assert_select "form[action=?][method=?]", criterium_path(criterium), "post" do

      assert_select "input[name=?]", "criterium[name]"

      assert_select "input[name=?]", "criterium[scale]"
    end
  end
end
