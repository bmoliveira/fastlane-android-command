module Fastlane
  module Helper
    class AndroidDevice
      attr_accessor :serial, :state

      def initialize(serial: nil, state: nil)
        self.serial = serial
        self.state = state
      end
    end

    class AndroidAdbHelper
      # Path to the adb binary
      attr_accessor :adb_path

      # All available devices
      attr_accessor :devices

      def initialize(adb_path: nil)
        self.adb_path = adb_path
      end

      # Run a certain action
      def trigger(command: nil, serial: nil, print_command: true, print_command_output: true)
        android_serial = serial != "" ? "ANDROID_SERIAL=#{serial}" : nil
        command = [android_serial, adb_path, command].join(" ")
        Action.sh(command, print_command: print_command, print_command_output: print_command_output)
      end

      # Waits for a device to complete the bootloader animation
      def wait_for_boot(device: nil)
        UI.user_error! "Device not  given" unless device
        timeout_in_sec = 360
        counter_in_sec = 0
        print "Waiting for target device to come online"
        loop do
          break if emulator_booted?(device: device)
          sleep 1
          counter_in_sec += 1
          print '.'
          break if counter_in_sec > timeout_in_sec
        end
        UI.user_error!("Could not start emulator") if counter_in_sec > timeout_in_sec
        UI.message "Started android emulator"
      end

      # Shuts down an emulator
      def stop_device(serial: nil)
        UI.user_error! "Device not  given" unless serial
        trigger(serial: serial, command: "-s #{serial} emu kill", print_command_output: false) if serial
      end

      # Kills all the connected android emulators
      def stop_all_devices
        Action.sh("#{adb_path} devices | grep emulator | cut -f1 | while read line; do #{adb_path} -s $line emu kill; done")
      end

      # Checks if the emulator device has completly booted
      def emulator_booted?(device: nil)
        output = trigger(
          serial: device.serial,
          command: "shell getprop | grep init.svc.bootanim &",
          print_command: false,
          print_command_output: false
        )
        output.split("\n").each do |line|
          result = output.match("\\[(stopped)\\]")
          return true if result && result[1] == "stopped"
        end
        return false
      end

      # Returns the list of all android devices
      def load_all_devices
        self.devices = []
        command = [adb_path, "devices"].join(" ")
        output = Actions.sh(command, log: false)
        output.split("\n").each do |line|
          result = line.match("(emulator-\\d+)[^a-zA-Z]*([a-z]+)")
          if result && result[1] && result[2]
            self.devices << AdbDevice.new(serial: result[1], state: result[2])
          end
        end
        self.devices
      end
    end
  end
end
