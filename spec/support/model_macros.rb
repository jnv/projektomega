module ModelMacros

  shared_examples "number sorted model" do

    it "should be ordered by number" do
      Factory(factory, number: 2)
      Factory(factory, number: 3)
      Factory(factory, number: 1)

      records = described_class.all

      records[0].number.should == 1
      records[1].number.should == 2
      records[2].number.should == 3
    end

  end

end

RSpec.configuration.include ModelMacros, type: :model