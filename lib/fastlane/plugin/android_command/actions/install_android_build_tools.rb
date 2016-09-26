module Fastlane
  module Actions
    class InstallAndroidBuildToolsAction < Action
      def self.run(params)
        android = Helper::AndroidHelper.new(android_path: params[:android_path])
        android.install_build_tools(revision: params[:build_tools_revision])
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.description
        "Install android build tools"
      end

      def self.details
        [
          'Installs an Android Build Tools revision'
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :build_tools_revision,
                                       env_name: 'FL_ANDROID_BUILD_TOOLS_REVISION',
                                       description: 'Android revision of build tools eg: 24.0.2',
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :android_path,
                                       env_name: 'FL_ANDROID_PATH',
                                       description: 'The path to your `android` binary',
                                       is_string: true,
                                       optional: true,
                                       default_value: 'android')
        ]
      end

      def self.authors
        ['bmoliveira']
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
