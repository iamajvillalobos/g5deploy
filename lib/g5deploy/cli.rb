require 'thor'

module G5deploy
  class KubernetesHelper < Thor
    desc "hello <string", "hello world"
    def hello(string)
      puts "Hello #{string}"
    end
  end
end
