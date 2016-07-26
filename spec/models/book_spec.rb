require 'rails_helper'

RSpec.describe Book, :type => :model do
  it { should respond_to :title }
  it { should respond_to :isbn }
  it { should respond_to :cover }
  it { should validate_presence_of :title }
  it { should validate_length_of(:isbn).is_at_least(9) }
  it { should validate_uniqueness_of :isbn }
  it { should have_many(:authors).through(:publications) }
  it { should belong_to :publisher }
end
