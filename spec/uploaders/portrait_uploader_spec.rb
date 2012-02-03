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

  describe "main version" do
    subject { @uploader }

    it { should have_permissions(0644) }
    it { should be_no_larger_than(90, 110) }
  end

  describe "thumb version" do
    subject { @uploader.thumb }
    it { should be_no_larger_than(40, 50) }
  end

end