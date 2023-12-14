require "rails_helper"

RSpec.describe TeacherDistributionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/teacher_distributions").to route_to("teacher_distributions#index")
    end

    it "routes to #new" do
      expect(get: "/teacher_distributions/new").to route_to("teacher_distributions#new")
    end

    it "routes to #show" do
      expect(get: "/teacher_distributions/1").to route_to("teacher_distributions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/teacher_distributions/1/edit").to route_to("teacher_distributions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/teacher_distributions").to route_to("teacher_distributions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/teacher_distributions/1").to route_to("teacher_distributions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/teacher_distributions/1").to route_to("teacher_distributions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/teacher_distributions/1").to route_to("teacher_distributions#destroy", id: "1")
    end
  end
end
