module ApplicationHelper
  def default_meta_tags
    {
      site: 'PICKUP TRACK',
      title: 'PICKUP TRACK',
      reverse: true,
      separator: '|',
      description: 'ランダムで歌う曲を決めてくれることにより、カラオケで歌う曲に悩む時間を減らし、カラオケをより楽しめるようにするアプリケーション',
      canonical: 'https://pickup-track.com',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
        { href: image_url('icon.png'), rel: 'icon', size: '192x192', type: 'image/png' }
      ],
      og: {
        site_name: 'PICKUP TRACK',
        title: 'PICKUP TRACK',
        description: 'ランダムで歌う曲を決めてくれることにより、カラオケで歌う曲に悩む時間を減らし、カラオケをより楽しめるようにするアプリケーション',
        type: 'website',
        url: 'https://pickup-track.com',
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image'
      }
    }
  end
end
