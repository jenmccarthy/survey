require 'spec_helper'

describe Choice do
  it { should have_and_belong_to_many :results}
end
