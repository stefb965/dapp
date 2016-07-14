module Dapp
  module Config
    # Shell
    class Shell
      attr_reader :_infra_install, :_infra_setup, :_app_install, :_app_setup
      attr_reader :_infra_install_cache_version, :_infra_setup_cache_version, :_app_install_cache_version, :_app_setup_cache_version

      def initialize
        @_infra_install = []
        @_infra_setup   = []
        @_app_install   = []
        @_app_setup     = []
      end

      def infra_install(*args, cache_version: nil)
        @_infra_install.concat(args)
        @_infra_install_cache_version = cache_version
      end

      def infra_setup(*args, cache_version: nil)
        @_infra_setup.concat(args)
        @_infra_setup_cache_version = cache_version
      end

      def app_install(*args, cache_version: nil)
        _app_install.concat(args)
        @_app_install_cache_version = cache_version
      end

      def app_setup(*args, cache_version: nil)
        _app_setup.concat(args)
        @_app_setup_cache_version = cache_version
      end

      def to_h
        {
          infra_install:               _infra_install,
          infra_install_cache_version: _infra_install_cache_version,
          infra_setup:                 _infra_setup,
          infra_setup_cache_version:   _infra_setup_cache_version,
          app_install:                 _app_install,
          app_install_cache_version:   _app_install_cache_version,
          app_setup:                   _app_setup,
          app_setup_cache_version:     _app_setup_cache_version
        }
      end

      def clone
        Marshal.load(Marshal.dump(self))
      end
    end
  end
end