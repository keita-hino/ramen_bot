class Linemenu
  # テスト用
  # liffのURLを送信
  def search_form(liff_url,kind)
    {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "bubble",
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "box",
              layout: "vertical",
              margin: "md",
              contents: [
                {
                  type: "button",
                  style: "link",
                  height: "sm",
                  action: {
                    type: "uri",
                    label: "#{kind}画面へ",
                    uri: liff_url
                  }
                }
              ]
            }
          ]
        }
      }
    }
  end

  def search_result(food)

    {
    type: "flex",
      altText: "this is a flex message",
      contents: {
        type: 'carousel',
        contents:
          food.map do |v|
            {
              type: 'bubble',
              hero: {
                type: 'image',
                size: 'full',
                aspectRatio: '20:13',
                url: ENV['RAMEN_PICTURE_PATH'] + v['id'].to_s + "/" + v['picture'].to_s
              },
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'box',
                    layout: 'horizontal',
                    margin: 'xl',
                    contents: [
                      {
                        type: 'text',
                        text: '　　　　店名',
                        color: '#aaaaaa',
                        size: 'md',
                        align: 'center',
                        flex: 1
                      },
                      {
                        type: 'text',
                        text: v['store_name'],
                        wrap: true,
                        weight: 'bold',
                        size: 'md',
                        flex: 1
                      }
                    ]
                  },
                  {
                    type: 'box',
                    layout: 'horizontal',
                    margin: 'lg',
                    contents: [
                      {
                        type: 'text',
                        text: '　　メニュー',
                        color: '#aaaaaa',
                        size: 'md',
                        align: 'center',
                        flex: 1
                      },
                      {
                        type: 'text',
                        text: v['menu_name'],
                        wrap: true,
                        weight: 'bold',
                        size: 'md',
                        flex: 1
                      }
                    ]
                  },
                  {
                    type: 'box',
                    layout: 'horizontal',
                    margin: 'lg',
                    contents: [
                      {
                        type: 'text',
                        text: '　スープの味',
                        color: '#aaaaaa',
                        size: 'md',
                        align: 'center',
                        flex: 1
                      },
                      {
                        type: 'text',
                        text: v['taste'],
                        wrap: true,
                        weight: 'bold',
                        size: 'md',
                        flex: 1
                      }
                    ]
                  },
                  {
                    type: 'box',
                    layout: 'horizontal',
                    margin: 'lg',
                    contents: [
                      {
                        type: 'text',
                        text: '　　麺の太さ',
                        color: '#aaaaaa',
                        size: 'md',
                        align: 'center',
                        flex: 1
                      },
                      {
                        type: 'text',
                        text: v['thickness'],
                        wrap: true,
                        weight: 'bold',
                        size: 'md',
                        flex: 1
                      }
                    ]
                  },
                  {
                    type: 'box',
                    layout: 'horizontal',
                    margin: 'lg',
                    contents: [
                      {
                        type: 'text',
                        text: '　　麺の硬さ',
                        color: '#aaaaaa',
                        size: 'md',
                        align: 'center',
                        flex: 1
                      },
                      {
                        type: 'text',
                        text: v['hardness'],
                        wrap: true,
                        weight: 'bold',
                        size: 'md',
                        flex: 1
                      }
                    ]
                  },
                  {
                    type: 'box',
                    layout: 'horizontal',
                    margin: 'lg',
                    contents: [
                      {
                        type: 'text',
                        text: 'スープの濃さ',
                        color: '#aaaaaa',
                        size: 'md',
                        align: 'center',
                        flex: 1
                      },
                      {
                        type: 'text',
                        text: v['taste_intensity'],
                        wrap: true,
                        weight: 'bold',
                        size: 'md',
                        flex: 1
                      }
                    ]
                  },
                  {
                    type: 'box',
                    layout: 'horizontal',
                    margin: 'lg',
                    contents: [
                      {
                        type: 'text',
                        text: '　　　評価',
                        color: '#aaaaaa',
                        size: 'md',
                        align: 'center',
                        flex: 1
                      },
                      {
                        type: 'text',
                        text: v['evalute'].to_s,
                        wrap: true,
                        weight: 'bold',
                        size: 'md',
                        flex: 1
                      }
                    ]
                  }
                ]
              },
              footer: {
                type: 'box',
                layout: 'vertical',
                spacing: 'sm',
                contents: [
                  {
                    type: 'button',
                    style: 'primary',
                    action: {
                      type: 'uri',
                      label: 'シェアする',
                      uri: 'https://store.shopping.yahoo.co.jp/elephant/880266-a.html'
                    }
                  },
                  {
                    type: 'spacer',
                    size: 'lg'
                  }
                ]
              }
            }
        end
      }
    }
  end
end
