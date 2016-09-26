module Fastlane
  module Helper
    class AndroidHelper
      # Path to the android binary
      attr_accessor :android_path

      def initialize(android_path: nil)
        self.android_path = android_path
      end

      # Run a certain action
      def trigger(command: nil, print_command: true, print_command_output: true)
        command = [android_path, command].join(" ")
        Action.sh(command, print_command: print_command, print_command_output: print_command_output)
      end

      # Install/update a certain build tools version
      def install_build_tools(revision: nil)
        filter = list_sdk_filter_option(match_regex: "\\s*(\\d+)(.*SDK Build-tools.*#{revision})")
        UI.user_error! "Could not find the build tools revision: #{revision}" unless filter
        update_sdk(filter: filter)
      end

      # Install/update the android sdk tools
      def install_sdk_tools
        filter = list_sdk_filter_option(match_regex: "\\s*(\\d+)(.*SDK Tools)")
        UI.user_error! "Could not find any SDK tools" unless filter
        update_sdk(filter: filter)
      end

      # Install/update the android platform tools
      def install_platform_tools
        filter = list_sdk_filter_option(match_regex: "\\s*(\\d+)(.*Platform-tools)")
        UI.user_error! "Could not find any Platform-tools" unless filter
        update_sdk(filter: filter)
      end

      # Install/update certain android sdk platform tools
      def install_sdk(android_target_int: 1, google_apis: false, accept_terms: true)
        regex = "\\s*(\\d+)(.*SDK Platform.*API #{android_target_int})"
        regex = "\\s*(\\d+)(.*Google APIs,.*API #{android_target_int})" if google_apis
        filter = list_sdk_filter_option(match_regex: regex)
        UI.user_error! "Could not find the android sdk platform for sdk: #{android_target_int} google_apis? #{google_apis}" unless filter
        update_sdk(filter: filter)
      end

      # Install/update certain android system image for a android version target and abi type
      def install_system_image(android_target_int: nil, android_abi: nil, accept_terms: true)
        UI.message "installing - sys-img-#{android_abi}-android-#{android_target_int}".green
        filter = "sys-img-#{android_abi}-android-#{android_target_int}"
        update_sdk(filter: filter, accept_terms: accept_terms)
      end

      # Creates am avd with a name for a specific version and abi
      def create_avd(name: nil, android_target_int: nil, android_abi: nil)
        command = "create avd --force -n #{name} -t android-#{android_target_int} --abi #{android_abi}"
        command = ["echo no |", android_path, command].join(" ")
        Action.sh(command, print_command_output: false)
      end

      # Runs the update command of the sdk given an filter option
      def update_sdk(filter: nil, accept_terms: true)
        command = "update sdk --no-ui"
        filter = " --all --filter #{filter}" if filter
        accept_terms = "echo y |" if accept_terms
        command = [accept_terms, android_path, command, filter].join(" ")
        Action.sh(command, print_command_output: false)
      end

      private

      # Selectes an option to update from the list given a regex expression
      def list_sdk_filter_option(match_regex: nil)
        option = nil
        matched_filter = nil
        action_list.split("\n").each do |line|
          if (result = line.match(match_regex))
            option = result[1]
            matched_filter = result[2]
          end
        end
        UI.message "Installing #{matched_filter}" if matched_filter
        return option
      end

      # Lists the available options for the update command
      def action_list
        @action_list ||= trigger(command: "list sdk --all", print_command_output: false)
      end
    end
  end
end
