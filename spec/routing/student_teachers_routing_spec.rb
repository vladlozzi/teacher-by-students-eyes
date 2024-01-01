require "rails_helper"

RSpec.describe StudentTeachersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/student_teachers").to route_to("student_teachers#index")
    end

    it "routes to #new" do
      expect(get: "/student_teachers/new").to route_to("student_teachers#new")
    end

    it "routes to #show" do
      expect(get: "/student_teachers/1").to route_to("student_teachers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/student_teachers/1/edit").to route_to("student_teachers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/student_teachers").to route_to("student_teachers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/student_teachers/1").to route_to("student_teachers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/student_teachers/1").to route_to("student_teachers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/student_teachers/1").to route_to("student_teachers#destroy", id: "1")
    end
  end
end
