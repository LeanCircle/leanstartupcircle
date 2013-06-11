module Gollum
  class Wiki
    def initialize(path, options = {})
      options = self.class.default_options.merge(options)
      if path.is_a?(GitAccess)
        options[:access] = path
        path             = path.path
      end

      # Use .fetch instead of ||
      #
      # o = { :a => false }
      # o[:a] || true # => true
      # o.fetch :a, true # => false

      @path                 = path
      @repo_is_bare         = options.fetch :repo_is_bare, nil
      @page_file_dir        = options.fetch :page_file_dir, nil
      @access               = options.fetch :access, GitAccess.new(path, @page_file_dir, @repo_is_bare)
      @base_path            = options.fetch :base_path, "/"
      @page_class           = options.fetch :page_class, self.class.page_class
      @file_class           = options.fetch :file_class, self.class.file_class
      @markup_classes       = options.fetch :markup_classes, self.class.markup_classes
      @repo                 = @access.repo
      @ref                  = options.fetch :ref, self.class.default_ref
      @sanitization         = options.fetch :sanitization, self.class.sanitization
      @ws_subs              = options.fetch :ws_subs, self.class.default_ws_subs
      @history_sanitization = options.fetch :history_sanitization, self.class.history_sanitization
      @live_preview         = options.fetch :live_preview, true
      @live_preview  = options.fetch(:live_preview, true)
      @universal_toc        = options.fetch :universal_toc, false
      @mathjax              = options.fetch :mathjax, false
      @show_all             = options.fetch :show_all, false
      @collapse_tree        = options.fetch :collapse_tree, false
      @css                  = options.fetch :css, false
      @h1_title             = options.fetch :h1_title, false

      @user_icons           = ['gravatar', 'identicon'].include?( options[:user_icons] ) ?
                              options[:user_icons] : 'none'
    end
  end
end