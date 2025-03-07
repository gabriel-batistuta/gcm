# README

# configurar mailer em app/config/environments/[development | production] or :
config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'google.com', # email domain
    user_name:            'hyoudouissei047@gmail.com',     # email real
    password:             'wjbr bvky bbcp iock',           # senha de app
    authentication:       'plain',
    enable_starttls_auto: true
}

```
# criar usuários padrões Admin e Usuário comum
rails console
User.create!(name: "Admin", email: "admin@example.com", password: "password", admin: true)
User.create!(name: "User", email: "user@example.com", password: "senha", admin: false)

# adicione um email real para poder receber o aviso de troca senha no email
User.create!(name: "SEUNOME", email: "seuEmail@gmail.com", password: "suasenha", admin: false)
```

Usuários de teste
```
adm:
  admin@example.com
  password

user:
  user@example.com
  senha

  batistutag190@gmail.com
  senhafoda
```
