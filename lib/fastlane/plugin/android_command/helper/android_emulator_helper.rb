module Fastlane
  module Helper
    class AndroidEmulatorHelper
      # Path to the emulator binary
      attr_accessor :emulator_path

      def initialize(emulator_path: nil)
        self.emulator_path = emulator_path
      end

      # Run a certain action
      def trigger(command: nil, print_command: true, print_command_output: true)
        command = [emulator_path, command].join(" ")
        Action.sh(command, print_command: print_command, print_command_output: print_command_output)
      end

      def start(name: nil)
        Thread.start do
          trigger(command: "-avd #{name} -no-audio -no-window &", print_command_output: false)
        end
        # Sleeping to wait for the emulator to start
        # Is impossible to actually get the start state of emulator because the output of the command is buggy
        # 5 is a bit on top but we want to make sure it starts
        sleep 5
      end
    end
  end
end
