require 'spec_helper'

describe Result do
  it { should have_and_belong_to_many :choices}
end
