require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "renders home page" do
    render
    assert_select 'h5', text: "Івано-Франківський національний технічний університет нафти і газу", count: 1
    assert_select 'h2', text: "Онлайн-опитування", count: 1
    assert_select 'h3>a', text: "Увійти через пошту ІФНТУНГ @nung.edu.ua", count: 1
    assert_select 'h6', text: "_______© В. Лозинський, 2023", count: 1
  end
end
