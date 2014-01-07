DESTINATIONS = ["name=iPhone Retina (3.5-inch),OS=7.0",
                "name=iPhone Retina (4-inch),OS=7.0",
                "name=iPhone Retina (4-inch 64-bit),OS=7.0"]

desc 'Clean, Build and Test'
task :default => [:clean, :build, :test]

desc 'Clean'
task :clean do
  system("xcodebuild clean -scheme UUIDShortener | xcpretty -c")
end

desc 'Build'
task :build do
  system("xcodebuild -scheme UUIDShortener CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO | xcpretty -c")
end

desc "Test"
task :test do
  DESTINATIONS.each do |destination|
    system("xcodebuild test -scheme UUIDShortener -configuration Debug -sdk iphonesimulator -destination \"#{destination}\" | xcpretty -c")
  end
end
