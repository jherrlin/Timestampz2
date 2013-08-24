require 'spec_helper'

describe Assignment do

  it { should have_many :student_assignments }
  it { should have_many :students }
  it { should belong_to :day_class }

  it { should validate_presence_of :name }
  it { should validate_presence_of :due_date }
  it { should validate_presence_of :day_class }
end
