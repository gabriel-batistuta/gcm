# README

Usuários de teste
```
adm:
admin@exemplo.com
adminadmin

user:
usuario@exemplo.com
senha123
```

# configurar mailer em app/config/environments/[development | production] or :
config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'google.com', # email domain
    user_name:            'hyoudouissei047@gmail.com',     # email real
    password:             'wjbr bvky bbcp iock',               # senha de app
    authentication:       'plain',
    enable_starttls_auto: true
}