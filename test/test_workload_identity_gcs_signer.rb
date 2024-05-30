require "minitest/autorun"
require 'google/cloud/storage'
require "workload_identity_gcs_signer"

class GcsSignerTest < Minitest::Test
  def test_sign_not_on_google_compute
    expected_signature = 'foo&bar&baz'
    
    mock_env = Minitest::Mock.new
    mock_env.expect(:compute_engine?, false)

    mock_file = Minitest::Mock.new
    mock_file.expect(:signed_url, expected_signature, method: "GET", expires: 3600)

    Google::Cloud.stub :env, mock_env do
      assert expected_signature, GcsSigner.sign_url(file: mock_file, method: "GET", expires: 3600)
    end
  end

  def test_sign_on_google_compute
    # TODO
  end
end
