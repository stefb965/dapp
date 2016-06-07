module Dapp
  module Stage
    class Source3 < Base
      def name
        :source_3
      end

      def image
        super do |image|
          build.git_artifact_list.each do |git_artifact|
            git_artifact.source_3_apply!(image)
          end
        end
      end

      def signature
        hashsum [build.stages[:infra_setup].signature,
                 app_setup_file,
                 *build.app_setup_commands, # TODO chef
                 *build.git_artifact_list.map { |git_artifact| git_artifact.source_3_commit }]
      end

      def app_setup_file
        @app_setup_file ||= begin
          File.read(app_setup_file_path) if app_setup_file?
        end
      end

      def app_setup_file?
        File.exist?(app_setup_file_path)
      end

      def app_setup_file_path
        build.build_path('.app_setup')
      end
    end # Source3
  end # Stage
end # Dapp