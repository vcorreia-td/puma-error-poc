namespace :ruby_service do
  desc 'bootstraps the service'
  task :bootstrap, [:service_name] do |_task, service_name:|

    # rename directories and files
    Dir.glob('**/*') do |file_path|
      if file_path.include? 'my_service_name'
        new_path = file_path.gsub(/my_service_name/, service_name)

        FileUtils.mv(file_path, new_path) rescue nil
      end
    end

    # rename file contents where MyServiceName & my_service_name occur
    Dir.glob('**/*.rb') do |file_path|
      new_contents =
        File.read(file_path)
        .gsub(/my_service_name/, service_name)
        .gsub(/MyServiceName/, camelize(service_name))

      File.open(file_path, 'w') { |f| f.puts new_contents }
    end
  end

  def camelize(name)
    name.split('_').map(&:capitalize).join
  end
end
