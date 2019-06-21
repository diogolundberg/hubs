# frozen_string_literal: true

require_relative 'config/environment'

desc 'Start REPL session (short-cut alias: "c")'
task :console do
  require_relative 'config/boot'
  Pry.start
  exit!(0)
end

task c: :console
task pry: :console

Dir.glob('./lib/tasks/**/*.rake').each { |task| load(task) }
