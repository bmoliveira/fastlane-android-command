module Fastlane
  module Actions
    class InstallAndroidSdkAction < Action
      def self.run(params)
        android = Helper::AndroidHelper.new(android_path: params[:android_path])
        android.install_sdk(android_target_int: params[:android_sdk_version])
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.description
        "Install android SDK version"
      end

      def self.details
        [
          'Installs an Android SDK version'
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :android_sdk_version,
                                       description: 'Android SDK int version eg:. 24',
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
