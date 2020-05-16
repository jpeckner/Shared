Pod::Spec.new do |s|
  s.name = 'Shared'
  s.version = '1.1.3'
  s.license = 'MIT'
  s.summary = 'Swift iOS framework containing code for networking, location services, UI, and more.'
  s.homepage = 'https://github.com/jpeckner/Shared'
  s.authors = { 'Justin Peckner' => 'pecknerj@gmail.com' }
  s.source = { :git => 'https://github.com/jpeckner/Shared.git', :tag => '1.1.3' }

  s.ios.deployment_target = '12.0'
  s.source_files = 'Shared/**/*.swift'
  s.swift_version = '5.1'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-weak_framework SwiftUI' }
end
