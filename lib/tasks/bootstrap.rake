namespace :ruby_service do
  desc 'bootstraps the service'
  task :bootstrap, %i[service_name module_name] do |_task, service_name:, module_name: camelize(service_name)|
    Dir.glob('**/*') do |file_path|
      rename_files(file_path, service_name) if file_path.include? 'my_service_name'
    end

    file_content_replacement_globs = [
      '**/*.{ru,rb}',
      'Rakefile',
    ]

    file_content_replacement_globs.each { |glob|
      Dir.glob(glob) do |file_path|
        replace_file_contents(file_path, service_name, module_name)
      end
    }

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

def replace_file_contents(file_path, service_name, module_name)
  file_contents = File.read(file_path)

  new_contents =
    file_contents
    .gsub(/my_service_name/, service_name)
    .gsub(/MyServiceName/, module_name)

  File.open(file_path, 'w') { |file| file.puts new_contents }
end

def camelize(name)
  name.split('_').map(&:capitalize).join
end
