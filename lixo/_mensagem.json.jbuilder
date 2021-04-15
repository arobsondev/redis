json.extract! mensagem, :id, :titulo, :corpo, :created_at, :updated_at
json.url mensagem_url(mensagem, format: :json)
