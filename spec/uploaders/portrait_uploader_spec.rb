require 'spec_helper'
require 'carrierwave/test/matchers'

describe PortraitUploader do
  include CarrierWave::Test::Matchers

  before do
    PortraitUploader.enable_processing = true
    @character = Factory.create(:character)
    @uploader = PortraitUploader.new(@character, :portrait_test)
    @uploader.store!(File.open(Rails.root + 'spec/fixtures/images/portrait.jpg'))
  end

  after do
    PortraitUploader.enable_processing = false
  end

  subject { @uploader }

  it("should have permission 0644") { should have_permissions(0644) } #XXX Ambiguous description

  context 'thumb' do
    subject { @uploader.thumb }
    it("should be resized to 40x50 max.") { should be_no_larger_than(40, 50) } #XXX Ambiguous description
  end



end