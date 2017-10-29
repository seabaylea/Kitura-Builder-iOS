# Copyright IBM Corporation 2017
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

gem 'xcodeproj'
require 'xcodeproj'

project_file = ARGV[0]
version = ARGV[1]

if version.to_s.empty?
  exit
end

project = Xcodeproj::Project.open(project_file)

fixConfiguration = lambda do |configuration|
  configuration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = version
end

project.build_configurations.each(&fixConfiguration)
project.targets.each { |target| target.build_configurations.each(&fixConfiguration) }

project.save
