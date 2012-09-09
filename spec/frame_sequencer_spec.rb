require_relative 'frame-sequence'

# Stub
class VideoTag
  attr_reader :timestamp

  def initialize(timestamp)
    @timestamp = timestamp
  end
end

# Frame Sequencer Tests
describe "frame sequencer" do
  it "gets the most frequently occuring frame sequence from an Array" do
    video_tags = [  VideoTag.new(100),
                    VideoTag.new(200),
                    VideoTag.new(301),
                    VideoTag.new(399),
                    VideoTag.new(498),
                    VideoTag.new(598) ]

    most_frequent = frame_sequence(video_tags)
    most_frequent.should == 100
  end

  it "picks only one value in the event of a tie" do
    video_tags = [  VideoTag.new(100),
                    VideoTag.new(200),
                    VideoTag.new(301),
                    VideoTag.new(402) ]

    most_frequent = frame_sequence(video_tags)
    most_frequent.is_a?(Fixnum).should == true
  end

end


