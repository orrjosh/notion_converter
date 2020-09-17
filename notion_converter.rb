#! /usr/bin/ruby
require 'shellwords'
require 'pry'

def walk_tree(directory, export_dir, target_dir)
    puts "Directory arg #{directory}"
    Dir.chdir(directory)
    arr = Dir.entries(Dir.pwd)
    arr.each do |fs_obj|
        target_path = build_output_path(directory, fs_obj, export_dir, target_dir)
        if(fs_obj.start_with?('.')) 
            # noop to skip `.`, `..`, and `.DS_Store`.  There were no hidden directories in the notion export for the Production Engineering space
        elsif fs_obj.end_with?('.md')
            Dir.chdir(directory)
            system("pandoc \"#{fs_obj}\" --output=\"#{target_path}.docx\" -f markdown -w docx")

        elsif fs_obj.end_with?('.csv') || fs_obj.end_with?('.png')
            system("cp \"#{directory}/#{fs_obj}\" \"#{target_path}\"")
        elsif File.directory?("#{directory}/#{fs_obj}")
            system("mkdir -p \"#{target_path}\"")
            begin
                walk_tree("#{directory}/#{fs_obj}", export_dir, target_dir)
            rescue Exception => ex
                puts ex
            end
        else
            puts "Don't know what to do with #{fs_obj}"
        end
    end
end

def build_output_path(current_directory, fs_obj_name, export_dir, target_dir)
    target_path = "#{current_directory}/#{fs_obj_name}"
    target_path = target_path.gsub(export_dir, target_dir)
end


# Main
if ARGV.length < 2
    puts "Not enough args, the format is `./notion_converter {notion_export_dir} {target_dir}`"
    exit
end

export_dir = ARGV[0]
export_path = "#{Dir.pwd}/#{ARGV[0]}"
target_dir = ARGV[1]

walk_tree(export_path, export_dir, target_dir)