require 'spec_helper'

describe MissionAttendance do

  it { should belong_to :mission }
  it { should belong_to :character }

  it "should have multiple primary ids" do
    MissionAttendance.primary_key.should eq([:mission_id, :character_id])
  end

end
