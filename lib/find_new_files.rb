Dir.glob("/home/brian/Dropbox/eBook**/*.{epub,pdf,mobi,html,prc,rtf,pdb,txt,lit}") do |filename|
  filename = filename.to_s
  Resque.enqueue(ProcessEbook, filename)
  puts "Queued #{filename} to Resque"
end