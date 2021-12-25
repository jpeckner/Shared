Pod::Spec.new do |s|
  s.name = 'SharedTestComponents'
  s.module_name = 'SharedTestComponents'
  s.version = '1.1.5'
  s.summary = 'Test components for Shared framework.'
  s.homepage = 'https://github.com/jpeckner/Shared'
  s.authors = { 'Justin Peckner' => 'pecknerj@gmail.com' }
  s.license = 'MIT'
  s.source = { 
    :git => 'https://github.com/jpeckner/Shared.git', 
    :tag => 'v' + s.version.to_s 
  }

  s.ios.deployment_target = '12.0'
  s.source_files = 'SharedTestComponents/**/*.swift'
  s.swift_version = '5.1'
  s.resources = ['SharedTestComponents/Sourcery/Templates/*']

  s.dependency 'Shared', '' + s.version.to_s
end
