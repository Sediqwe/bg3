set :rails_env, :production
append :linked_files,  "config/master.key", "config/credentials/production.key"

server "bg3.forditas.xyz",
       user: "deploy",
       roles: %w{web app db},
       ssh_options: {
           user: "deploy", # overrides user setting above
           keys: %w(~/.ssh/id_rsa.pub),
           forward_agent: false,
           auth_methods: %w(publickey),
           port: 2323

       }
