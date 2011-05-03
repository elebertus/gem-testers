desc "Populate the users and authors table with json data from gemcutter."
task :populate_authors do
  # change to use less or more threads -- be mindful of the traffic you'll generate!
  threads = 5 

  require 'thread'
  require 'config/environment'
  require 'gem_cutter'
  require 'pp'
  gems = Rubygem.all.to_a

  length = (gems.length / threads).floor

  gems_p = []

  threads.times do |x|
    offset = length * x
    gems_p.push gems[offset..(length*(x+1))-1].compact
  end

  gems_p[0] += gems[(length*threads)..-1]

  puts_mutex = Mutex.new
 
  pool = []

  threads.times do |thread_num|
    pool.push(
      Thread.new do
        gems_p[thread_num].each do |this_gem|
          puts_mutex.synchronize do
            puts "Processing #{this_gem.name}"
          end

          this_gem.retrieve_authors
        end
      end
    )
  end

  pool.map(&:join)
end
