require 'thor'

module G5deploy
  class KubernetesHelper < Thor

    desc "deploy <environment>", "deploy production or deploy staging"
    option :with_migration
    def deploy(environment)
      if environment == "production" && options[:with_migration]
        cmd = "kubectl config use-context g5-prod && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml \
        -f k8s/db-migrate.yaml"
        run_command(cmd)
      elsif environment == "production"
        cmd = "kubectl config use-context g5-prod && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml"
        run_command(cmd)
      elsif environment == "staging" && options[:with_migration]
        cmd = "kubectl config use-context integrations-staging && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml \
        -f k8s/db-migrate.yaml"
        run_command(cmd)
      elsif environment == "staging"
        cmd = "kubectl config use-context integrations-staging && kubectl \
        apply -f k8s/sidekiq-workers.yaml -f k8s/rails-servers.yaml"
        run_command(cmd)
      else
        puts "Command not found!".upcase
      end
    end

    desc "pods <environment>", "pods production or pods staging"
    def pods(environment)
      if environment == "production"
        cmd = "kubectl config use-context g5-prod && kubectl get pods"
        run_command(cmd)
      elsif environment == "staging"
        cmd = "kubectl config use-context integrations-staging && kubectl get pods"
        run_command(cmd)
      else
        puts "Command not found!".upcase
      end
    end

    desc "logs <pod_name>", "pods integrations-rails-servers-1905410877-5zfej"
    def logs(pod_name)
      cmd = "kubectl exec -it #{pod_name} -- /bin/bash -f"
      run_command(cmd)
    end

    private

    def run_command(cmd)
      IO.popen(cmd) do |io|
        io.each { |s| print s }
      end
    end

  end
end
