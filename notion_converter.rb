#! /usr/bin/ruby
require 'shellwords'
require 'pry'

def walk_tree(directory, target_dir)
    puts "Directory arg #{directory}"
    Dir.chdir(directory)
    puts "working dir #{Dir.pwd}"
    arr = Dir.entries(Dir.pwd)
    arr.each do |fs_obj|
        if(fs_obj.start_with?('.')) 
            puts "skipping hidden dir #{fs_obj}"
        elsif fs_obj.end_with?('.md')
            puts "convert this #{fs_obj}"
        elsif fs_obj.end_with?('.csv') || fs_obj.end_with?('.png')
            puts "copy this #{fs_obj}"
        elsif File.directory?("#{directory}/#{fs_obj}")
            puts "this is a dir #{fs_obj}"
            target_path = "#{directory}/#{fs_obj}"
            target_path = target_path.gsub(directory, target_dir)
            system("mkdir -p \"#{target_path}\"")
            begin
                walk_tree("#{directory}/#{fs_obj}", target_dir)
            rescue Exception => ex
                puts ex
            end
        else
            puts "Don't know what to do with #{fs_obj}"
        end
    end
end

def convert(file_path)
#use pandoc command to convert markdown to docx
end

def copy_to_converted(file_path, converted_dir)
end

# Main
if ARGV.length < 2
    puts "Not enough args, the format is `./notion_converter {notion_export_dir} {target_dir}`"
    exit
end

export_dir = "#{Dir.pwd}/#{ARGV[0]}"
target_dir = ARGV[1]

#arr = Dir.entries(export_dir)
walk_tree(export_dir, target_dir)


#Dir.mkdir(target_dir) unless Dir.exists?(target_dir)