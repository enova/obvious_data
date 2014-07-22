require 'spec_helper'

describe 'sanity' do
  it 'checks sanity' do
    ObviousData.should be_kind_of Module
  end
end
