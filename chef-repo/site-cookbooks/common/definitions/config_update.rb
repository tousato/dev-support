Chef::Log.init($stdout)
Chef::Log.level(:info)

define :conf_update do
  Chef::Log.logger.info "#{params}"
  install_dir = params[:name]

  params[:confs].each do |file, conf|
    src = "#{install_dir}/#{file}"

    bash "Backup #{src}" do
      only_if "test -f #{src}"

      creates "#{src}.ORG"
      code "cp -p '#{src}' '#{src}.ORG'"
    end

    ruby_block "Update #{src}" do
      block do
        FileUtils.cp src, "#{src}.old"

        f = Chef::Util::FileEdit.new "#{src}"
        conf.each do |key, value|
          value.to_s.gsub!([\\]) { |c| '\\' + c }
          f.insert_line_if_no_match(/^#{key}\s*=/, "#{key}=#{value}")
          f.search_file_replace_line(/^#{key}\s*=/, "#{key}=#{value}")
        end
        f.write_file
      end
      action :run

      bash "Check update #{src}" do
        not_if "diff #{src} #{src}.old"
        code "echo updated #{src} file"
        notifies :restart, "service[#{params[:initd_script]}]"
      end
    end
  end
end
