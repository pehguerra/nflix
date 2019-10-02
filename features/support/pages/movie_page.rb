class MoviePage
    include Capybara::DSL

    def initialize
        @movie_list_css = 'table tbody tr'
    end

    def add
        find('.nc-simple-add').click
    end

    def upload(file)
        cover_file = File.join(Dir.pwd, 'features/support/fixtures/covers/' + file)
        cover_file = cover_file.tr("/", "\\") if OS.windows?

        Capybara.ignore_hidden_elements = false
        attach_file('upcover', cover_file)
        Capybara.ignore_hidden_elements = true
    end

    def add_cast(cast)
        actor = find('.input-new-tag')
        cast.each do |a|
            actor.set a
            actor.send_keys :tab
        end
    end

    def select_status(status)
        find('input[placeholder=Status]').click
        find('.el-select-dropdown__item', text: status).click
    end

    def release_date(date)
        find('input[name=release_date]').set date
        find('input[name=release_date]').send_keys :tab
    end

    def create(movie)
        # title
        find('input[name=title]').set movie['title']

        # status
        select_status(movie['status']) unless movie['status'].empty?

        # year
        find('input[name=year]').set movie['year']

        # release date
        release_date(movie['release_date']) unless movie['release_date'].empty?

        # cast
        add_cast(movie['cast'])

        # ovewview
        find('textarea[name=overview]').set movie['overview']

        # cover
        upload(movie['cover']) unless movie['cover'].empty?

        # cadastrar
        find('#create-movie').click
    end

    def movie_tr(title)
        find(@movie_list_css, text: title)
    end    

    def alert
        find('.alert').text
    end

    def remove(title)
        movie_tr(title).find('.btn-trash').click
    end

    def swal2_confirm
        find('.swal2-confirm').click
    end

    def swal2_cancel
        find('.swal2-cancel').click
    end

    def has_no_movie(title)
        page.has_no_css?(@movie_list_css, text: title)
    end

    def has_movie(title)
        page.has_css?(@movie_list_css, text: title)
    end
end