KManager.action :bootstrap do
  action do
    application_name = :kweb05_devise_unit_test

    director = KDirector::Dsls::RubyGemDsl
      .init(k_builder,
        on_exist:                   :skip,                      # %i[skip write compare]
        on_action:                  :queue                      # %i[queue execute]
      )
      .data(
        ruby_version:               '2.7',
        application:                application_name,
        application_description:    'Sample Rails 7 application using with mini test integration tests',
        author:                     'David Cruwys',
        author_email:               'david@ideasmen.com.au',
        initial_semver:             '0.0.1',
        main_story:                 '',
        copyright_date:             '2022',
        website:                    'http://appydave.com/gems/kweb05-devise-unit-test'
      )
      .github(
        active: true,
        repo_name: application_name,
        organization: 'klueless-rails7-poc'
      ) do
        create_repository
        # delete_repository
        # list_repositories
        open_repository
        # run_command('git init')
      end
      .blueprint(
        active: true,
        name: :bin_hook,
        description: 'initialize repository',
        on_exist: :write) do

        cd(:app)

        run_template_script('bin/runonce/git-setup.sh', dom: dom)

        add('.githooks/commit-msg').run_command('chmod +x .githooks/commit-msg')
        add('.githooks/pre-commit').run_command('chmod +x .githooks/pre-commit')

        add('.gitignore', template_file: '.gitignore-rails')

        run_command('git config core.hooksPath .githooks') # enable sharable githooks (developer needs to turn this on before editing rep)

        run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
        run_command("gh repo edit -d \"#{dom[:application_description]}\"")
      end
      .blueprint(
        active: true,
        name: :opinionated,
        description: 'opinionated GEM files',
        on_exist: :write) do

        cd(:app)

        # add('README.md', dom: dom)

        run_command("rubocop -a")
      
        run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      .blueprint(
        active: true,
        name: :ci_cd,
        description: 'github actions (CI/CD)',
        on_exist: :write) do

        cd(:app)

        run_command("gh secret set GEM_HOST_API_KEY --body \"$GEM_HOST_API_KEY\"")

        add('.github/workflows/main.yml')

        run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end

    director.play_actions
    # director.builder.logit
  end
end

KManager.opts.app_name                    = 'kweb05-devise-unit-test'
KManager.opts.sleep                       = 2
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'
