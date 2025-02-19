module AnnouncementsHelper

  # Outputs given announcement in HTML (with optional twitter bootstrap style).
  #
  # Basic usage: <%= announce Announcement.newest %>
  # Alt usage: <%= announce Announcement.newest, :format => "boostrap" %>
  #
  # Options:
  # div_class -- name for a custom div class, which wraps the announcement text and hide message, default is "info"
  # hide_message -- clickable text which hides the announcement, default is "hide message"
  # format[:boostrap] -- format announcement to use the twitter bootstrap Alert style, defaults to normals stylings.
  # alert_heading -- Adding an alert heading when used with the bootstrap option.
  def announce announcement, options = {}
    result = nil

    if announcement != nil && cookies["announcement_" + announcement.id.to_s] != "hidden"
      data_attribute = { :announcementid => announcement.id }
      if options[:format] == "bootstrap"
        text = options[:hide_message] || "x"
        block_announcement = options[:block_announcement] || announcement.block_announcement || false
        div_class = options[:div_class] || block_announcement ? "alert" : "alert alert-block"
        alert_heading = (options[:alert_heading] || announcement.title || "Announcement!") << " "

        close_content_tag = content_tag(:button, text, :class => "close", type: "button", data: data_attribute.merge(:"dismiss" => "alert"))
      
        if block_announcement
          alert_content_tag = content_tag(:h4, alert_heading)
        else
          alert_content_tag = content_tag(:strong, alert_heading)          
        end
        result = content_tag(:div, close_content_tag + alert_content_tag + announcement.body.html_safe, class: div_class)
      else
        text = options[:hide_message] || "hide message"
        div_class = options[:div_class] || "info"

        close_content_tag = content_tag(:span, text, :class => "hide_announcement", data: data_attribute)

        result = content_tag(:div, announcement.body.html_safe + close_content_tag, class: div_class)
      end
    end

    result
  end

end
