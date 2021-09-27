Pod::Spec.new do |s|
  s.name = 'SharedTestComponents'
  s.version = '1.1.4'
  s.license = 'MIT'
  s.summary = 'Test components for Shared framework.'
  s.homepage = 'https://github.com/jpeckner/Shared'
  s.authors = { 'Justin Peckner' => 'pecknerj@gmail.com' }
  s.source = { :git => 'https://github.com/jpeckner/Shared.git', :tag => '1.1.4' }

  s.ios.deployment_target = '12.0'
  s.source_files = 'SharedTestComponents/**/*.swift'
  s.swift_version = '5.1'
  s.dependency 'Shared', '~> 1.1.0'
  s.resources = ['SharedTestComponents/Sourcery/Templates/*']
end
