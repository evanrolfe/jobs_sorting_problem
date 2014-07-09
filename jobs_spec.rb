require 'pry'
require './jobs'

#Iterate through each constraint and check that the sequence follows it
RSpec::Matchers.define :follow_constraints do |constraints|
  match do |sequence|
  	constraints.reject!{ |k,v| v.nil? }
    constraints.each do |job_after, job_before|
    	return false if sequence.index(job_before) > sequence.index(job_after)
    end
    return true
  end
end

#A test for a test
describe "follow_constraints matcher" do

	it "returns true if a sequence follows the given constraints" do
  	sequence = ['a', 'f', 'd', 'c', 'b', 'e']
  	constraints = {'a' => nil, 'b' => 'c', 'c' => 'f', 'd' => 'a', 'e' => 'b', 'f' => nil}
  	expect(sequence).to follow_constraints(constraints)
	end

	it "returns false if a sequence does not follows the given constraints" do
  	sequence = ['a', 'f', 'd', 'c', 'b', 'e']
  	constraints = {'a' => 'f', 'b' => 'c', 'c' => 'f', 'd' => 'a', 'e' => 'b', 'f' => nil}
  	expect(sequence).to_not follow_constraints(constraints)
	end
end

describe Jobs do
	it "returns an empty sequence when no jobs are passed to it" do
		sequence = Jobs.permute()
	  expect(sequence).to be_nil
	end

	it "returns a single sequence when only one job is passed to it" do
		sequence = Jobs.permute({'a' => nil})
	  expect(sequence).to equal(['a'])
	end

	it "returns any sequence when jobs are passed to it with no conditions on the ordering" do
		sequence = Jobs.permute({'a' => nil, 'b' => nil, 'c' => nil})
	  expect(sequence).to include('a', 'b', 'c')
	end

	it "returns a sequence that follows the contraints imposed on it" do
		contraints = {'a' => nil, 'b' => 'c', 'c' => nil}
		sequence = Jobs.permute(constraints)
	  expect(sequence).to follow_constraints(constraints)
	end

	it "returns a sequence that follows the contraints imposed on it (2)" do
  	constraints = {'a' => nil, 'b' => 'c', 'c' => 'f', 'd' => 'a', 'e' => 'b', 'f' => nil}
		sequence = Jobs.permute(constraints)
	  expect(sequence).to follow_constraints(constraints)
	end

	it "throws an error when the constraints contain a job which follows itself" do
  	constraints = {'a' => nil, 'b' => nil, 'c' => 'c'}
		sequence = Jobs.permute(constraints)
		expect(sequence).to raise_error(SelfDependentConstraintsError)
	end

	it "throws an error when the constraints contain circular depedencies" do
  	constraints = {'a' => nil, 'b' => 'c', 'c' => 'f', 'd' => 'a', 'e' => nil, 'f' => 'b'}
		sequence = Jobs.permute(constraints)
		expect(sequence).to raise_error(CircularConstraintsError)
	end
end