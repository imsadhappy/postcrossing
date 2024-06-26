# README

* `docker-compose up -d` for postgres & redis
* install gems: `bundle install` (install solargraph & rubocop for development)
* run dev server: `rails s` or `rails server`
* run tailwind watcher: `rails tailwindcss:watch`
* edit dev credentials: `EDITOR="code --wait" rails credentials:edit --environment=development`
* edit prod credentials: `EDITOR="code --wait" rails credentials:edit --environment=production`
* reset db: `rake db:drop db:create db:migrate`

* TODO: configure error pages https://mattbrictson.com/blog/dynamic-rails-error-pages

Version 0.3.6
- pagination
- stats combined into one table
- pages controller

Version 0.3.5
- redis stats daily expiration
- added address field to user
- pages controller

Version 0.3.4
- redis storage for stats
- fix sign out with cookie delete

Version 0.3.3
- form styling & refac

Version 0.3.2
- concerns: user, session & locale managers

Version 0.3.1
- stats for registrations, visits, pageviews & newsreads

Version 0.3.0
- stats

Version 0.2.1
- minor styling

Version 0.2.0
- user menu

Version 0.2.0
- user about

Version 0.1.6
- caching setup

Version 0.1.5
- user groups instead of role

Version 0.1.4
- i18n

Version 0.1.3
- session cookie setup
- redirects
- application helpers

Version 0.1.2
- renamed identity into account
- added account details & destroy

Version 0.1.1
- added omniauth for google & facebook
- created production & development credentials
