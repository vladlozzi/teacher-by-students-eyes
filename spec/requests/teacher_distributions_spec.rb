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

RSpec.describe "/teacher_distributions", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # TeacherDistribution. As you add validations to TeacherDistribution, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { person_id: Person.create!(full_name: "Person1Distr", email: "email1@email.com").id,
      unit_id: Unit.create!(name: "Unit1ForDistr", unit_type: "Department").id
    }
  }

  let(:invalid_attributes) { { person_id: nil, unit_id: nil } }

  describe "GET /index" do
    it "renders a successful response" do
      TeacherDistribution.create! valid_attributes
      get teacher_distributions_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      teacher_distribution = TeacherDistribution.create! valid_attributes
      get teacher_distribution_url(teacher_distribution)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_teacher_distribution_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      teacher_distribution = TeacherDistribution.create! valid_attributes
      get edit_teacher_distribution_url(teacher_distribution)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new TeacherDistribution" do
        expect {
          post teacher_distributions_url, params: { teacher_distribution: valid_attributes }
        }.to change(TeacherDistribution, :count).by(1)
      end

      it "redirects to the created teacher_distribution" do
        post teacher_distributions_url, params: { teacher_distribution: valid_attributes }
        expect(response).to redirect_to(teacher_distribution_url(TeacherDistribution.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new TeacherDistribution" do
        expect {
          post teacher_distributions_url, params: { teacher_distribution: invalid_attributes }
        }.to change(TeacherDistribution, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post teacher_distributions_url, params: { teacher_distribution: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { person_id: Person.create!(full_name: "Person2Distr", email: "email2@email.com").id,
          unit_id: Unit.create!(name: "Unit2ForDistr", unit_type: "Department").id
        }
      }

      it "updates the requested teacher_distribution" do
        teacher_distribution = TeacherDistribution.create! valid_attributes
        patch teacher_distribution_url(teacher_distribution), params: { teacher_distribution: new_attributes }
        teacher_distribution.reload
        expect(teacher_distribution[:person_id] ).to eq(new_attributes[:person_id])
        expect(teacher_distribution[:unit_id] ).to eq(new_attributes[:unit_id])
      end

      it "redirects to the teacher_distribution" do
        teacher_distribution = TeacherDistribution.create! valid_attributes
        patch teacher_distribution_url(teacher_distribution), params: { teacher_distribution: new_attributes }
        teacher_distribution.reload
        expect(response).to redirect_to(teacher_distribution_url(teacher_distribution))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        teacher_distribution = TeacherDistribution.create! valid_attributes
        patch teacher_distribution_url(teacher_distribution), params: { teacher_distribution: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested teacher_distribution" do
      teacher_distribution = TeacherDistribution.create! valid_attributes
      expect {
        delete teacher_distribution_url(teacher_distribution)
      }.to change(TeacherDistribution, :count).by(-1)
    end

    it "redirects to the teacher_distributions list" do
      teacher_distribution = TeacherDistribution.create! valid_attributes
      delete teacher_distribution_url(teacher_distribution)
      expect(response).to redirect_to(teacher_distributions_url)
    end
  end
end