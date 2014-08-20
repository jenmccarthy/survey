require 'spec_helper'

describe Question do
  it { should have_and_belong_to_many :surveys }
  it { should have_and_belong_to_many :responses }
end
