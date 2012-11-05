require 'minitest_helper'

class TestDoc
  include Mongoid::Document
  include Mongoid::Document::Taggable
end

describe Mongoid::Document::Taggable do
  it "adds tags from a comma separated list via the tag_list attr" do
    doc = TestDoc.create(:tag_list => 'one, two, three, yes')
    doc.tags.wont_be :empty?
  end

  it "finds documents tagged with given tag(s)" do
    TestDoc.create(:tag_list => 'one, two, three, yes')
    TestDoc.create(:tag_list => 'four, five, six, yes')
    TestDoc.create(:tag_list => 'seven, eight, nine, ten')

    results1 = TestDoc.tagged_with('yes')
    results2 = TestDoc.tagged_with(['five', 'ten'])

    results1.wont_be :empty?
    results1.length.must_equal 2
    results2.wont_be :empty?
    results2.length.must_equal 2
  end

  it "returns a unique list of all tags across a given document type" do
    _tags = [['one', 'two'], ['three', 'four'], ['five', 'six'], ['yes', 'no'], ['go']]
    _tags.each do |tags|
      TestDoc.create(:tag_list => tags.join(','))
    end

    TestDoc.tags.must_equal _tags.flatten.uniq
  end
end
