release: bin/rails db:migrate
web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
web: bundle exec puma -C config/puma.rb