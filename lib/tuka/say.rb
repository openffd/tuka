# frozen_string_literal: true

module Tuka
  module Say
    COMMAND = 'say'
    DEFAULT_VOICE = 'Alex'

    def say(something)
      system COMMAND, something
    end

    def say_with_voice(something, voice = DEFAULT_VOICE)
      system COMMAND, something, '-v', voice
    end
  end
end
