DESTINATIONS = ["name=iPhone Retina (3.5-inch),OS=7.0",
                "name=iPhone Retina (4-inch),OS=7.0",
                "name=iPhone Retina (4-inch 64-bit),OS=7.0"]

desc 'Clean, Build and Test'
task :default => [:clean, :build, :test]

desc 'Clean'
task :clean do
  sh "xcodebuild clean -scheme UUIDShortener | xcpretty -c; exit ${PIPESTATUS[0]}"
end

desc 'Build'
task :build do
  sh "xcodebuild build -scheme UUIDShortener CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO | xcpretty -c; exit ${PIPESTATUS[0]}"
end

desc "Test"
task :test do
  DESTINATIONS.each do |destination|
    sh "xcodebuild test -scheme UUIDShortener -configuration Debug -sdk iphonesimulator -destination \"#{destination}\" | xcpretty -tc; exit ${PIPESTATUS[0]}"
  end
end
