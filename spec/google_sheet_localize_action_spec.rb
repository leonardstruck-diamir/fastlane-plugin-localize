describe Fastlane::Actions::GoogleSheetLocalizeAction do
  describe '.available_options' do
    it 'defines the required options' do
      keys = Fastlane::Actions::GoogleSheetLocalizeAction.available_options.map(&:key)
      expect(keys).to include(:service_account_path, :sheet_id, :language_titles, :localization_path)
    end
  end

  describe Fastlane::Helper::GoogleSheetLocalizeHelper do
    it 'builds a service account authorization' do
      require 'openssl'
      require 'json'
      require 'tempfile'
      key = Tempfile.new(['key', '.json'])
      key.write(JSON.generate(type: 'service_account', client_email: 'a@b.iam.gserviceaccount.com',
                              private_key: OpenSSL::PKey::RSA.new(2048).to_pem, token_uri: 'https://oauth2.googleapis.com/token'))
      key.close
      expect { described_class.new(key.path, 'sheet') }.not_to raise_error
    end
  end
end
