require 'spec_helper'

describe StudentsController do
  let(:student) { FactoryGirl.create(:student) }
  let(:school) { FactoryGirl.create(:school) }
  let(:day_class) { FactoryGirl.create(:day_class) }
  let(:group) { FactoryGirl.create(:group) }
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe "#new" do
    it "returns success" do
      get(:new)
      response.should be_successful
    end
  end

  describe '#create' do
    before(:each) do
      @params = { student: { '0' => { last_name: "Tyler", first_name: "Rose", grade_level: "6th"}}}
    end

    context 'with correct params' do
      it 'redirects' do
        post(:create, @params)
        response.should redirect_to(students_path)
      end

      it 'saves to the database' do
        expect{ post :create, @params }.to change{Student.count}.by(1)
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'incorrect params' do
      it 'renders new' do
        Student.any_instance.stub(:save).and_return(nil)
        Student.any_instance.stub_chain(:errors, :full_messages).and_return(["Error"])
        post('create', @params)
        flash[:errors].should_not be_blank
      end
    end
  end

  describe "#edit" do
    before(:each) do
      Student.stub(:find).and_return(student)
      get('edit', id:student.object_id)
    end

    it "returns success" do
      response.should be_successful
    end

    it "assigns @student" do
      assigns(:student).should == student
    end
  end

  describe 'update' do
    before(:each) do
      Student.stub(:find).and_return(student)
    end

    context 'successful update' do
      before(:each) do
        put('update', id:student.object_id)
      end
      
      it 'redirects upon success' do
        response.should be_redirect
      end

      it 'flashes a success message' do
        flash[:success].should_not be_blank
      end
    end

    context 'unsuccessful update' do
      it 'renders edit' do
        Student.any_instance.stub(:update_attributes).and_return(nil)
        put('update', id: student.object_id, student: { name: ""})
        response.should render_template 'edit'
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      Student.stub(:find).and_return(student)
    end

    it "redirects upon success" do
      delete('destroy', id:student.object_id)
      response.should be_redirect
    end

    it "destroys the student object" do
      count = student.count
      delete('destroy', id:student.object_id)
      Student.count.should == count - 1
    end
  end

  before :each do
    sign_in
  end

  describe '#index' do
    before :each do
      get :index
    end

    it 'assigns do' do
      expect(assigns(:to)).st eq([assignment])
    end

    it 'renders index page' do
      expect(response).to render_template("index")
    end
  end

  describe '#create' do

    before :each do
      ApplicationController.any_instance.stub(:current_user).and_return()
      @params = { assignment: { '0' => { name: "Assignment 1", due_date: Time.now, day_class_id: day_class.id }}}
    end

    context 'with correct params' do
      it 'redirects' do
        post(:create, @params)
        response.should redirect_to(assignments_path)
      end

      it 'saves to the database' do
        expect{ post :create, @params }.to change{Assignment.count}.by(1)
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'incorrect params' do
      it 'flashes error' do
        Assignment.any_instance.stub(:save).and_return(nil)
        Assignment.any_instance.stub_chain(:errors, :full_messages).and_return(["Error"])
        post('create', @params)
        flash[:errors].should_not be_blank
      end
    end
  end

  describe '#update' do

    it 'changes assignments attributes' do
      assignment_attributes = {
        name: 'new name'
      }
      post :update, id: assignment.id, assignment: assignment_attributes
      Assignment.first.name.should == 'new name'
    end

    it 'redirects to index' do
      post :update, id: assignment.id
      expect(response).to redirect_to(assignments_path)
    end
  end

  describe '#destroy'do

    it 'deletes an assignment' do
      assignment
      expect{
        delete :destroy, id: assignment.id
      }.to change{Assignment.count}.by(-1)
    end

    it 'redirects to index' do
      delete :destroy, id: assignment.id
      expect(response).to redirect_to(assignments_path)
    end
  end

end