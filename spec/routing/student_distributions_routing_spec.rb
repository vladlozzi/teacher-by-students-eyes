require "rails_helper"

RSpec.describe StudentDistributionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/student_distributions").to route_to("student_distributions#index")
    end

    it "routes to #new" do
      expect(get: "/student_distributions/new").to route_to("student_distributions#new")
    end

    it "routes to #show" do
      expect(get: "/student_distributions/1").to route_to("student_distributions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/student_distributions/1/edit").to route_to("student_distributions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/student_distributions").to route_to("student_distributions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/student_distributions/1").to route_to("student_distributions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/student_distributions/1").to route_to("student_distributions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/student_distributions/1").to route_to("student_distributions#destroy", id: "1")
    end
  end
end
