module OpenAI
  class Assistants
    def initialize(client:)
      @client = client
    end

    def list
      @client.get(path: "/assistants")
    end

    def create(parameters: {})
      @client.json_post(path: "/assistants", parameters: parameters)
    end

    def retrieve(id:)
      @client.get(path: "/assistants/#{id}")
    end

    def modify(id:, parameters: {})
      @client.post(path: "/assistants/#{id}", parameters: parameters)
    end

    def delete(id:)
      @client.delete(path: "/assistants/#{id}")
    end

    def list_files(id:)
      @client.get(path: "/assistants/#{id}/files")
    end

    def create_file(id:, parameters: {})
      @client.json_post(path: "/assistants/#{id}/files", parameters: parameters)
    end

    def retrieve_file(id:, file_id:)
      @client.get(path: "/assistants/#{id}/files/#{file_id}")
    end

    def delete_file(id:, file_id:)
      @client.delete(path: "/assistants/#{id}/files/#{file_id}")
    end
  end
end
