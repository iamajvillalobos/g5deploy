require 'thor'

module G5deploy
  class KubernetesHelper < Thor

    desc "deploy <environment>", "deploy production or deploy staging"
    option :with_migration
    def deploy(environment)
      if environment == "production" && options[:with_migration]
        `kubectl config use-context g5-prod && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml \
        -f k8s/db-migrate.yaml`
      elsif environment == "production"
        `kubectl config use-context g5-prod && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml`
      elsif environment == "staging" && options[:with_migration]
        `kubectl config use-context integrations-staging && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml \
        -f k8s/db-migrate.yaml`
      elsif environment == "staging"
        `kubectl config use-context integrations-staging && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml`
      else
        puts "Command not found!".upcase
      end
    end

    desc "pods <environment>", "pods production or pods staging"
    def pods(environment)
      if environment == "production"
        `kubectl config use-context g5-prod && kubectl get pods`
      elsif environment == "staging"
        `kubectl config use-context integrations-staging && kubectl get pods`
      else
        puts "Command not found!".upcase
      end
    end

  end
end
