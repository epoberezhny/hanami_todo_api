Container.boot(:oj) do
  init do
    Oj.optimize_rails
    # Oj.default_options = { trace: true }
  end
end
