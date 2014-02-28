Pod::Spec.new do |s|
  s.name     = 'SPGroupedTabView'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Two-tiered or grouped tab view for Mac OS http://phildow.net/source-code/.'
  s.homepage = 'https://github.com/AFNetworking/AFNetworking'
  s.authors  = { 'Philip Dow' => 'phil@phildow.net'}
  s.source   = { :git => 'https://github.com/demianturner/SPGroupedTabView.git', :tag => '1.0.0' }
  s.source_files = 'SPGroupedTabView'
  s.requires_arc = true

  s.osx.deployment_target = '10.7'
  s.osx.frameworks = 'WebKit'

end