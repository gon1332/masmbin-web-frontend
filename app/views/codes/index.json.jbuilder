json.array!(@codes) do |code|
  json.extract! code, :id, :assembly_source
  json.url code_url(code, format: :json)
end
