
stack = caller_locations(4)
control "json-stack" do
  describe JSON.dump(stack) do
    its('length') { should be 0 } # intentionally fail, just dump
  end
end
