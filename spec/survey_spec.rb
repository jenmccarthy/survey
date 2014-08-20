require 'spec_helper'

describe Survey do
  it { should have_and_belong_to_many :questions }
  it { should have_many :responses }
  it { should validate_presence_of :name }
end
