# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://meshitelog.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/posts'
  #
  add posts_path, priority: 0.7, changefreq: 'daily'
  add top_rated_posts_path, priority: 0.6, changefreq: 'daily'
  add recommended_posts_path, priority: 0.6, changefreq: 'daily'
  add received_posts_path, priority: 0.5, changefreq: 'daily'
  add bookmarks_posts_path, priority: 0.5, changefreq: 'daily'
  add scheduled_posts_path, priority: 0.4, changefreq: 'daily'
  #
  # Add all posts:
  #
  Post.find_each do |post|
    add post_path(post), lastmod: post.updated_at
    add edit_post_path(post), lastmod: post.updated_at
  end

  add new_post_path, priority: 0.5, changefreq: 'daily'

  add profile_path
  add edit_profile_path

  add terms_path, priority: 0.2, changefreq: 'monthly'
  add privacy_path, priority: 0.2, changefreq: 'monthly'
end
