#! /usr/bin/ruby
def walk_tree(directory)
    #puts "Directory arg #{directory}"
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
        else
            puts "this is a dir #{fs_obj}"
            walk_tree("#{Dir.pwd}/#{fs_obj}")
        end
    end
end
if ARGV.length < 2
    puts "Not enough args, the format is `./notion_converter {notion_export_dir} {target_dir}`"
    exit
end

export_dir = ARGV[0]
target_dir = ARGV[1]

#arr = Dir.entries(export_dir)
walk_tree(export_dir)


Dir.mkdir(target_dir) unless Dir.exists?(target_dir)