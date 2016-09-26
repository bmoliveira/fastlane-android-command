module Fastlane
  module Actions
    class InstallAndroidPlatformToolsAction < Action
      def self.run(params)
        android = Helper::AndroidHelper.new(android_path: params[:android_path])
        android.install_platform_tools
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.description
        "Install android Platform-Tools"
      end

      def self.details
        [
          'Installs the latest Android Platform-Tools version'
        ].join("\n")
      end

      def self.available_options
        [
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
