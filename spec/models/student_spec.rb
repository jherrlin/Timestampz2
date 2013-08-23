require 'spec_helper'

describe Student do

  it { should have_many :student_groups }
  it { should have_many(:groups).through(:student_groups) }
  it { should have_many :student_assignments }
  it { should have_many(:assignments).through(:student_assignments) }
  it { should have_many :student_day_classes }
  it { should have_many(:day_classes).through(:student_day_classes) }
  it { should belong_to :school }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :grade_level }

  it "should return last name alphabetically" do
    FactoryGirl.create(:student, last_name: "Jones", first_name: "John", grade_level: "A", school_id: "1")
    FactoryGirl.create(:student, last_name: "Smith", first_name: "John", grade_level: "A", school_id: "2")
    FactoryGirl.create(:student, last_name: "Johnson", first_name: "John", grade_level: "A", school_id: "3")
    Student.first.last_name.should eq "Johnson"
  end

end
