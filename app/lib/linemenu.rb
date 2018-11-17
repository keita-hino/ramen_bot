class Linemenu
  # テスト用
  # liffのURLを送信
  def get_search_form(liff_url,kind)
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
end
