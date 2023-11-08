module OpenAI
  class Client
    include OpenAI::HTTP

    CONFIG_KEYS = %i[
      api_type
      api_version
      access_token
      organization_id
      uri_base
      request_timeout
    ].freeze
    attr_reader *CONFIG_KEYS
    attr_accessor :is_beta, :extra_headers

    def initialize(config = {})
      CONFIG_KEYS.each do |key|
        # Set instance variables like api_type & access_token. Fall back to global config
        # if not present.
        instance_variable_set("@#{key}", config[key] || OpenAI.configuration.send(key))
      end
      @extra_headers = config[:extra_headers] || OpenAI.configuration.send(:extra_headers) || {}
      @is_beta = config[:is_beta] || false
    end

    def chat(parameters: {})
      json_post(path: "/chat/completions", parameters: parameters)
    end

    def edits(parameters: {})
      json_post(path: "/edits", parameters: parameters)
    end

    def embeddings(parameters: {})
      json_post(path: "/embeddings", parameters: parameters)
    end

    def audio
      @audio ||= OpenAI::Audio.new(client: self)
    end

    def files
      @files ||= OpenAI::Files.new(client: self)
    end

    def finetunes
      @finetunes ||= OpenAI::Finetunes.new(client: self)
    end

    def images
      @images ||= OpenAI::Images.new(client: self)
    end

    def models
      @models ||= OpenAI::Models.new(client: self)
    end

    def moderations(parameters: {})
      json_post(path: "/moderations", parameters: parameters)
    end

    def azure?
      @api_type&.to_sym == :azure
    end

    def beta
      self.is_beta = true
      self
    end

    def assiatants
      self.extra_headers = extra_headers.merge({ "OpenAI-Beta": "assistants=v1" }) if is_beta
      @assiatants ||= OpenAI::Assistants.new(client: self)
    end

    def threads
      self.extra_headers = extra_headers.merge({ "OpenAI-Beta": "assistants=v1" }) if is_beta
      @threads ||= OpenAI::Threads.new(client: self)
    end
  end
end
