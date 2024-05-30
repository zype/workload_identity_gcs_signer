# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'workload_identity_gcs_signer'
  s.version     = '0.0.1'
  s.summary     = 'GCS signer that can be used in Workload Identity environments'
  s.description = 'Wraps the GCS signed URL functionality with functionality '\
                  'required to sign when there are no local credentials'
  s.authors     = ['Jon Eisenstein']
  s.email       = 'jon.eisenstein@backlight.co'
  s.files       = ['lib/workload_identity_gcs_signer.rb']
  s.homepage    =
    'https://https://github.com/zype/workload_identity_gcs_signer'
  s.license = 'MIT'
  s.add_runtime_dependency 'google-cloud-storage', '>= 1.29.0'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'byebug'

end
