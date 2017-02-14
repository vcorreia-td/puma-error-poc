namespace :ruby_service do
  desc 'bootstraps the service'
  task :bootstrap, [:service_name] do |_task, service_name:|
    Dir.glob('**/*') do |file_path|
      rename_files(file_path, service_name) if file_path.include? 'my_service_name'
    end

    Dir.glob('**/*.{ru,rb}') do |file_path|
      replace_file_contents(file_path, service_name)
    end

    puts ' Done.'
  end
end

def rename_files(file_path, new_name)
  new_path = file_path.gsub(/my_service_name/, new_name)

  begin
    FileUtils.mv(file_path, new_path)
  rescue
    nil
  end
end

def replace_file_contents(file_path, new_name)
  file_contents = File.read(file_path)

  new_contents =
    file_contents
    .gsub(/my_service_name/, new_name)
    .gsub(/MyServiceName/, camelize(new_name))

  File.open(file_path, 'w') { |f| f.puts new_contents }
end

def camelize(name)
  name.split('_').map(&:capitalize).join
end
