class Linemenu
  # テスト用
  # liffのURLを送信
  def get_search_form
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
                    label: "入力画面へ",
                    uri: ENV['LIFF_URL']
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
