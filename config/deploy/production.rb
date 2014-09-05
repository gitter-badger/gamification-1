server 'zeus.ugent.be', user: 'gamification', roles: %w{web app db},
  ssh_options: {
    forward_agent: true,
    auth_methods: ['publickey'],
    port: 2222
  }

set :rails_env, 'production'
