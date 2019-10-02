module Helpers
    def get_token
        sleep 0.500
        page.execute_script('return window.localStorage.getItem("default_auth_token");')
    end
end