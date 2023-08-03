module ApplicationHelper
  def page_title(page_title = '')
    base_title = t('defaults.app_name')

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = t('meta_tags.defaults')
    options.reverse_merge!(defaults)
    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('placeholder.png')
    configs = {
      separator: '|',
      reverse: true,
      site: site,
      title: title,
      description: description,
      keywords:,
      canonical: request.original_url,
      icon: {
        href: image_url('placeholder.png')
      },
      og: {
        type: 'website',
        title: title.presence || site,
        description: description,
        url: request.original_url,
        image: image,
        site_name: site
      },
      twitter: {
        site: site,
        card: 'summary_large_image',
        image: image
      }
    }
    set_meta_tags(configs)
  end
end
