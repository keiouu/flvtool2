require_relative '../../lib/flvtool2/version'
require_relative '../../lib/flvtool2/base'

# Attempting to mimic: flvtool2 -AUPt cuepoints.xml input.flv output.flv
def get_options
  options = {}
  options[:commands] = []
  options[:commands] << :add
  options[:commands] << :update
  options[:commands] << :print
  
  options[:tag_file] = File.expand_path('../data/example-tags.xml', File.dirname(__FILE__))
  
  options[:in_path] = File.expand_path('../data/tokyo-drift.flv', File.dirname(__FILE__))
  options[:out_path] = File.expand_path('../data/tokyo-drift-processed.flv', File.dirname(__FILE__))
  
  options[:metadatacreator] = "inlet media FLVTool2 v1.0.7 - http://www.inlet-media.de/flvtool2"
  options[:metadata] = {}
  options[:in_pipe] = false
  options[:out_pipe] = false
  options[:simulate] = false
  options[:verbose] = false
  options[:recursive] = false
  options[:preserve] = false
  options[:xml] = false
  options[:compatibility_mode] = false
  options[:in_point] = nil
  options[:out_point] = nil
  options[:keyframe_mode] = false
  options[:tag_number] = nil
  options[:stream_log] = true
  options[:collapse] = false
  
  return options
end

describe "flvtool2" do
  
  it "inserts cue events into an existing flv file" do
    puts get_options
    FLVTool2::Base::execute!( get_options )
  end

end


