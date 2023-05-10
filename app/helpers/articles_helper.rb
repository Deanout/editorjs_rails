module ArticlesHelper
    def display_content(content)
        parsed_content = JSON.parse(content)
        content_html = parsed_content['blocks'].map do |block|
            case block['type']
            when 'paragraph'
                "<p>#{block['data']['text']}</p>"
            when 'header'
                "<h#{block['data']['level']}>#{block['data']['text']}</h#{block['data']['level']}>"
            when 'list'
                list_items = block['data']['items'].map { 
                    |item| 
                    "<li>#{item}</li>" 
                }.join

                "<ul>#{list_items}</ul>"
            when "code"
                escaped_code = CGI.escapeHTML(block['data']['code'])
                "<pre><code>#{escaped_code}</code></pre>"
            when 'image'
                url = block['data']['file']['url']
                caption = block['data']['caption']
                with_border = block['data']['withBorder']
                with_background = block['data']['withBackground']
                stretched = block['data']['stretched']

                container_classes = ["image-container"]
                container_classes << "image-border" if with_border
                container_classes << "image-background" if with_background

                image_classes = ["image"]
                image_classes << "image-stretched" if stretched
                image_classes << "image-with-background" if with_background

                container_class = container_classes.join(' ')
                image_class = image_classes.join(' ')

                image_html = <<-HTML
                    <figure class="#{container_class}">
                        <img src='#{url}' alt='#{caption}' class='#{image_class}' />
                        <figcaption class="centered-content">#{caption}</figcaption>
                    </figure>
                HTML


            else
                ''
            end
        end
        content_html.join.html_safe
    end
end
