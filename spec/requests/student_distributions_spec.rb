require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/student_distributions", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # StudentDistribution. As you add validations to StudentDistribution, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { student: Student.create!(full_name: "Student1Distr", edebo_person_code: "1555"),
      group: Group.create!(group: "Group1ForStudentDistr"),
      edebo_study_code: "1111",
      email: "email1@email.com"
    }
  }

  let(:invalid_attributes) {
    { student: nil,
      group: nil,
      edebo_study_code: "",
      email: ""
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      StudentDistribution.create! valid_attributes
      get student_distributions_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      student_distribution = StudentDistribution.create! valid_attributes
      get student_distribution_url(student_distribution)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_student_distribution_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      student_distribution = StudentDistribution.create! valid_attributes
      get edit_student_distribution_url(student_distribution)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes_for_post) {
        { student_id: Student.create(full_name: "Student1Distr", edebo_person_code: "1555").id,
          group_id: Group.create!(group: "Group1ForStudentDistr").id,
          edebo_study_code: "1111",
          email: "email1@email.com"
        }
      }

      it "creates a new StudentDistribution" do
        expect {
          post student_distributions_url, params: { student_distribution: valid_attributes_for_post }
        }.to change(StudentDistribution, :count).by(1)
      end

      it "redirects to the created student_distribution" do
        post student_distributions_url, params: { student_distribution: valid_attributes_for_post }
        expect(response).to redirect_to(student_distribution_url(StudentDistribution.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new StudentDistribution" do
        expect {
          post student_distributions_url, params: { student_distribution: invalid_attributes }
        }.to change(StudentDistribution, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post student_distributions_url, params: { student_distribution: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { student_id: Student.create!(full_name: "Student2Distr", edebo_person_code: "2555").id,
          group_id: Group.create!(group: "Group2ForStudentDistr").id,
          edebo_study_code: 1112,
          email: "email2@email.com"
        }
      }

      it "updates the requested student_distribution" do
        student_distribution = StudentDistribution.create! valid_attributes
        patch student_distribution_url(student_distribution), params: { student_distribution: new_attributes }
        student_distribution.reload
        expect(student_distribution[:edebo_study_code] ).to eq(new_attributes[:edebo_study_code])
        expect(student_distribution[:email] ).to eq(new_attributes[:email])
      end

      it "redirects to the student_distribution" do
        student_distribution = StudentDistribution.create! valid_attributes
        patch student_distribution_url(student_distribution), params: { student_distribution: new_attributes }
        student_distribution.reload
        expect(response).to redirect_to(student_distribution_url(student_distribution))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        student_distribution = StudentDistribution.create! valid_attributes
        patch student_distribution_url(student_distribution), params: { student_distribution: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested student_distribution" do
      student_distribution = StudentDistribution.create! valid_attributes
      expect {
        delete student_distribution_url(student_distribution)
      }.to change(StudentDistribution, :count).by(-1)
    end

    it "redirects to the student_distributions list" do
      student_distribution = StudentDistribution.create! valid_attributes
      delete student_distribution_url(student_distribution)
      expect(response).to redirect_to(student_distributions_url)
    end
  end
end
