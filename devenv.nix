{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.laravel_project_directory = "./laravel"; # adapt this path when renaming the laravel directory

  # https://devenv.sh/packages/
  packages = with pkgs; [
    laravel
  ];

  # https://devenv.sh/languages/
  languages.php = {
    enable = true;
    package = pkgs.php84;
    packages.composer = pkgs.php84Packages.composer;
  };
  languages.javascript = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.nodejs_22;
  };

  # https://devenv.sh/processes/
  processes.artisan-serve.exec = "artisan serve";
  processes.npm-run-dev.exec = "cd $laravel_project_directory && npm run dev";

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
    };
  };

  # https://devenv.sh/scripts/
  scripts.artisan.exec = ''
    php $laravel_project_directory/artisan "$@"
  '';

  enterShell = ''
    echo
    echo 'ℹ️ php -v'
    php -v
    echo
    echo 'ℹ️ node -v'
    node -v
    echo
    echo 'ℹ️ npm -v'
    npm -v
    echo
    echo 'ℹ️ laravel -V'
    laravel -V
    echo
    echo -e "✅ \033[95martisan\033[0m is in your PATH now 😉"
    echo -e "you can run it via \033[95martisan <command>\033[0m from anywhere"
    echo -e "e.g. run \033[95martisan about\033[0m to print basic info about your laravel app"
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
