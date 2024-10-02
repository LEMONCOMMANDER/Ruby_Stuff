class Login
    def initialize()
        @credentials = {
                    # app_name: {
                        # UN
                        # PW
                    # }
            izotope: {
                username: 'template data',
                password: 'template data'
            }
        }
    end

    def new_cred(app_name, un, pw)
        @credentials[app_name] = {username: un, password: pw}
    end

    def get_cred(app_name)
        username = @credentials[app_name][:username]
        password = @credentials[app_name][:password]
        return [username, password]
    end

end
