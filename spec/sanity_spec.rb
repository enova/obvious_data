require 'spec_helper'

RSpec.describe 'sanity' do
  it 'checks sanity' do
    expect(ObviousData).to be_kind_of(Module)
  end
end
