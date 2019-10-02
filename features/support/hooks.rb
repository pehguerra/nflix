require 'base64'

Before do
    page.current_window.resize_to(1440, 900)
    @login_page = LoginPage.new
    @sidebar = SideBarView.new
    @movie_page = MoviePage.new
end

Before("@login") do
    @login_page.go
    @login_page.with(CONFIG['users']['cat_manager']['email'], CONFIG['users']['cat_manager']['pass'])
end

After do
    temp_shot = page.save_screenshot("log/temp_shot.png")
    screenshot = Base64.encode64(File.open(temp_shot, 'rb').read)
    embed(screenshot, "image/png", "Screenshot")
    
end