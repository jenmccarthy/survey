require 'spec_helper'

describe Question do
  it { should have_and_belong_to_many :surveys }
  it { should have_and_belong_to_many :responses }

  it { should validate_presence_of :question }
end
