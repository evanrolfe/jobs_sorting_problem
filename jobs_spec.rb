require './jobs'

describe Jobs do
  it "returns an empty sequence when no jobs are passed to it" do
  	result = Jobs.permute()
    expect(result).to be_nil
  end

  it "returns a single sequence when only one job is passed to it" do
  	result = Jobs.permute(['a' => nil])
    expect(result).to equal('a')
  end
end