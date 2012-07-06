def concat_dir(directory)
   contents = ''

   if File.directory?(directory)
      Dir.foreach(directory) do | filename |
         target_file = directory + '/' + filename
   	   if File.file?(target_file)
   	      contents.concat("# BEGIN #{target_file}\n")
            contents.concat(IO.read(target_file))
            contents.concat("# END #{target_file}\n")
         end
      end
   end
   return contents
end

basedir = '/etc/logstash'

config_text = "input {\n"
config_text.concat(concat_dir(basedir + '/inputs.d'))
config_text.concat("}\nfilter {\n")
config_text.concat(concat_dir(basedir + '/filters.d'))
config_text.concat("}\noutput {\n")
config_text.concat(concat_dir(basedir + '/outputs.d'))
config_text.concat("}\n")

#FIXME write the config yo
