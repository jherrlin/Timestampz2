require 'spec_helper'

describe School do

  it { should have_many :day_classes }
  it { should have_many :students }

end
