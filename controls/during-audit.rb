

stack = caller_locations(4)
control "json-stack" do
  describe stack.to_json do
    it { should be_kind_of String }
  end
end

require "inspec/utils/telemetry/run_context"

control "run-context" do
  describe Inspec::Telemetry::RunContextProbe.guess_run_context do
    it { should cmp "audit-cookbook" }
  end
end
