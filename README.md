<div style="margin: 24px;">
<img src="https://laravel.com/img/logomark.min.svg" width="84" style="padding: 0 -54px;" alt="laravel Logo">
<img src="https://devenv.sh/assets/logo.webp" width="300" style="margin-bottom: 18px;" alt="devenv Logo">
</div>

# laravel-devenv

This project serves as boilerplate code to easily setup a [devenv](https://devenv.sh/) environment for [laravel](https://laravel.com/).

## usage

1. get the boilerplate code
    1. either by just using this repository as template
    2. or by downloading the source code

        ```bash
        project=<YOUR_PROJECT_NAME> # replace <YOUR_PROJECT_NAME> with your project name
        wget -O laravel-devenv.zip https://github.com/devloberto/laravel-devenv/archive/refs/heads/master.zip
        unzip laravel-devenv.zip
        rm laravel-devenv.zip
        mv laravel-devenv-master $project
        cd $project
        # optional but recommended
        direnv allow .
        git init && git add . && git commit -m "initial commit"
        ```

2. scaffold laravel application

    The `$laravel_project_directory` environment variable is defined at the top of the `devenv.nix` file
    and its value is equivalent to the directory name that contains the laravel application.
    The default value is `laravel`.
    Change it in the `devenv.nix` file if you want to use a different directory name.

    ```bash
    scaffold-laravel
    ```

    The `scaffold-laravel` command is provided by the `devenv.nix` and
    utilises the [laravel CLI](https://github.com/laravel/installer).
    Mind the following:
    Skip the first step if the [laravel CLI](https://github.com/laravel/installer)
    asks for upgrading because it can not upgrade itself
    since it is installed as a nix package by [devenv](https://devenv.sh/).

3. adapt the DB configuration in `./$laravel_project_directory/.env`:

    ```dotenv
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=develobearer
    DB_USERNAME=develobear
    DB_PASSWORD=Test-1234
    ```

4. start your development environment

    ```bash
    devenv up
    ```

5. run the database migrations

    ```bash
    artisan migrate
    ```

Now you should see the laravel page at <http://localhost:8000> and the adminer login at <http://localhost:8810>.
