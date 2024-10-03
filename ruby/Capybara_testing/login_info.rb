require 'json'

class Login
=begin
    create a JSON format file called 'creds.json' and store in the same directory as this file. The intended fomrat is:
    "app_name": {"username": -- , "password": --}

    some things will return a true or false, the intention is to use this as a verification in the working code base if desired.
=end
    def initialize()
        puts " Login class: use .help() for details"
        puts "--------------------------------------"
        if File.exist?('creds.json')
            @credentials = JSON.parse(File.read('creds.json'), symbolize_names: true) # converts JSON to ruby object
        else
            File.write('creds.json', JSON.pretty_generate({})) # creates the missing file with {} empty object
            @credentials = {} # or create a new ojbect if nothing is found

        end
    end

    def help()
        puts <<~HEREDOC
            Login: If 'creds.json' is not present, it will be created - otherwise it will be read. Format for creds.json:
                    {
                        "app_name": {"username": -- , "password": --}
                    }

            new_cred? -- Takes the name of the application you are using, your username, and your password.
                        If the application is in creds.json, return false.  If not already there, it will be added and 
                        return true. A console log will also update the user. 

                        The return element can be used for testing in the scope of the code using this class
            
            delete_cred? -- Takes the name of the application and checks creds.json. If found, it will delete the key:value pair
                        and return true. Othewise, updates the user that no application was found and returns false.

            get_cred -- Searches creds.json for the application name and if found, returns an array with the username and password.
                        If not found, updates the user.

            get_creds -- logs all the application names and total count of applications found in creds.json.
                        Also returns an array with the application names. 
        HEREDOC
    end

    def new_cred?(app_name, un, pw)
        if @credentials.has_key?(app_name.to_sym) # == true
            puts "App already exists in @credentials"
            return false
        else
            @credentials[app_name] = {username: un, password: pw} # create ruby object entry
            File.write('creds.json', JSON.pretty_generate(@credentials)) # rewrites the file to JSON with changes
            
            puts "added \"#{app_name}\" to @credentials"
            return true
        end
    end

    def delete_cred?(app_name)
        app_name = app_name.to_sym
        if @credentials.has_key?(app_name)
            @credentials.delete(app_name) # deletes key:value pair
            File.write('creds.json', JSON.pretty_generate(@credentials)) # rewrites the file to JSON with changes

            puts "\"#{app_name}\" has been deleted from @credentials"
            return true
        else
            puts "there is no existing app in @credentials that matches: \"#{app_name}\""
            return false
        end
    end

    def get_cred(app_name) # gets a single credential  
        if @credentials.has_key?(app_name.to_sym)
            username = @credentials[app_name][:username]
            password = @credentials[app_name][:password]
            return [username, password]
        else
            puts "\"#{app_name}\" is not in @credentials"
        end
    end

    def get_creds() # information on all applications in creds.json - only uses keys.
        counter = 1
        r_list = []
        puts "============ APPLICATIONS ============"
        puts "    total applications: " + @credentials.length.to_s
        puts "   -------------------------"
        puts ""
        @credentials.each do |key, value|
            puts "application #{counter}: #{key}"
            counter += 1
        end
        puts "============ APPLICATIONS ============"
        ##############################################################
        counter = 1
        @credentials.each do |key, value|
            r_list.append("application #{counter}: #{key}")
            counter += 1
        end
        return r_list
    end
end
