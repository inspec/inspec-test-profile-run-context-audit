

stack = caller_locations(4)
control "json-stack" do
  describe stack.to_json do
    it { should be_kind_of String }
  end
end


# This is the sensible thing to do, but we can't do this until the RunContext
# feature is released and included with Chef Workstation.
# Why? Because the audit cookbook always uses the embedded inspec gem.

# require "inspec/utils/telemetry/run_context_probe"
# control "run-context" do
#   describe Inspec::Telemetry::RunContextProbe.guess_run_context do
#     it { should cmp "audit-cookbook" }
#   end
# end

# So instead, capture the stack to a file, and let the verify-stage
# "after-audit" profile handle checking the stack.
# Unfortunately, the JSON dump is lossy, and there is no direct Marshal implementation.
# So we have to make one.
Frame = Struct.new(:absolute_path, :label)
marshallable_stack = stack.map { |f| Frame.new(f.absolute_path, f.label) }
File.write("/tmp/audit_stack.dat", Marshal.dump(marshallable_stack))
