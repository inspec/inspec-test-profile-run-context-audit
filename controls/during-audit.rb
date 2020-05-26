

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
# Unfortunately, the JSON dump is lossy, so we need to do this a bit manually.
marshallable_stack = stack.map { |f| { absolute_path: absolute_path, label: label } }
File.write("/tmp/audit_stack.json", JSON.dump(marshallable_stack))
