module OpenAI
  class Threads
    def initialize(client:)
      @client = client
    end

    def create(parameters: {})
      @client.json_post(path: "/threads", parameters: parameters)
    end

    def retrieve(id:)
      @client.get(path: "/threads/#{id}")
    end

    def modify(id:, parameters: {})
      @client.post(path: "/threads/#{id}", parameters: parameters)
    end

    def delete(id:)
      @client.delete(path: "/threads/#{id}")
    end

    def list_messages(id:)
      @client.get(path: "/threads/#{id}/messages")
    end

    def create_message(id:, parameters: {})
      @client.json_post(path: "/threads/#{id}/messages", parameters: parameters)
    end

    def retrieve_message(id:, message_id:)
      @client.get(path: "/threads/#{id}/messages/#{message_id}")
    end

    def list_message_files(id:, message_id:)
      @client.get(path: "/threads/#{id}/messages/#{message_id}/files")
    end

    def list_message_files(id:, message_id:, file_id:)
      @client.get(path: "/threads/#{id}/messages/#{message_id}/files/#{file_id}")
    end
  end
end
