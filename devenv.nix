{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  # env.GREET = "devenv";

  # https://devenv.sh/packages/
  # packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  languages.php = {
    enable = true;
    package = pkgs.php83;
    packages.composer = pkgs.php83Packages.composer;
  };
  languages.javascript = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.nodejs_22;
  };

  # https://devenv.sh/processes/
  processes.artisan-serve.exec = "php artisan serve";
  processes.npm-run-dev.exec = "npm run dev";

  # https://devenv.sh/services/
  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb_114;
      ensureUsers = [
        {
          name = "develobear";
          ensurePermissions = {
            "*.*" = "ALL PRIVILEGES";
          };
          password = "Test-1234";
        }
      ];
      initialDatabases = [
        { name = "develobearer"; }
      ];
    };
    adminer = {
      enable = true;
      listen = "127.0.0.1:8810"; # default is 127.0.0.1:8080
      package = pkgs.adminer-pematon; # https://github.com/adminerneo/adminerneo
    };
  };

  # https://devenv.sh/scripts/
  # scripts.hello.exec = ''
  #   echo hello from $GREET
  # '';

  enterShell = ''
    echo '# php -v'
    php -v
    echo
    echo '# node -v'
    node -v
    echo
    echo '# npm -v'
    npm -v
    echo
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  # enterTest = ''
  #   echo "Running tests"
  #   git --version | grep --color=auto "${pkgs.git.version}"
  # '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
