describe Fastlane::Actions::AndroidCommandAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The android_command plugin is working!")

      Fastlane::Actions::AndroidCommandAction.run(nil)
    end
  end
end
