require 'spec_helper'

describe 'sanity' do
  it 'checks sanity' do
    expect(ObviousData).to be_kind_of(Module)
  end
end
