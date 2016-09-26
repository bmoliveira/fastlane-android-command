module Fastlane
  module Actions
    class InstallAndroidSdkToolsAction < Action
      def self.run(params)
        android = Helper::AndroidHelper.new(android_path: params[:android_path])
        android.install_sdk_tools
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.description
        "Install the most recent Android SDK tools"
      end

      def self.details
        [
          'Installs or Updates the Android SDK tools to the most recent version.'
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
