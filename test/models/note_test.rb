require 'minitest_helper'

describe Note do
  it "creates a note if all require fields are given" do
    note = Note.create(:title => 'A note', :body => 'Some words', :last_updated_by_ip => '127.0.0.1')
    note.must_be :valid?
    note.errors.must_be :empty?
  end

  it "fails validation if missing title or body field" do
    note1 = Note.create(:body => 'Some words', :last_updated_by_ip => '127.0.0.1')
    note2 = Note.create(:title => 'A note', :last_updated_by_ip => '127.0.0.1')

    note1.wont_be :valid?
    note1.errors.wont_be :empty?
    note2.wont_be :valid?
    note2.errors.wont_be :empty?
  end

  it "fails validation if updated_by_ip isn't a valid ip" do
    %w[blah 123.123.123 3333.234.234.234 34s.23b.33d.234].each do |ip|
      note = Note.create(:title => 'A note', :body => 'Some words', :last_updated_by_ip => ip)
      note.wont_be :valid?
      note.errors.wont_be :empty?
    end
  end
end
