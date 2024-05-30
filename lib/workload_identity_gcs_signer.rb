# frozen_string_literal: true

require 'google/cloud/env'
require 'google/apis/iamcredentials_v1'

# From https://github.com/googleapis/google-cloud-ruby/issues/13307
class GcsSigner
  def self.sign_url(file:, method:, expires:)
    cloud_env = Google::Cloud.env

    if cloud_env.compute_engine?
      # Issuer is the service account email that the Signed URL will be signed with
      # and any permission granted in the Signed URL must be granted to the
      # Google Service Account.
      issuer = cloud_env.lookup_metadata('instance', 'service-accounts/default/email')

      file.signed_url(method: method, expires: expires, issuer: issuer, signer: signer(issuer))
    else
      file.signed_url(method: method, expires: expires)
    end
  end

  def self.signer(issuer)
    # Create a lambda that accepts the string_to_sign
    lambda do |string_to_sign|
      iam_client = Google::Apis::IamcredentialsV1::IAMCredentialsService.new

      # Get the environment configured authorization
      scopes = ['https://www.googleapis.com/auth/iam']
      iam_client.authorization = Google::Auth.get_application_default scopes

      request = Google::Apis::IamcredentialsV1::SignBlobRequest.new(
        payload: string_to_sign
      )
      resource = "projects/-/serviceAccounts/#{issuer}"
      iam_client.sign_service_account_blob(resource, request).signed_blob
    end
  end
end
