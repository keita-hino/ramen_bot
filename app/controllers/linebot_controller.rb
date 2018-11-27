class LinebotController < ApplicationController
  before_action :set_food, only: [:search, :new]
  require 'line/bot'  # gem 'line-bot-api'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["RAMEN_LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["RAMEN_LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    user_id = events[0]["source"]["userId"]
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when '入力','write'
            message = Linemenu.search_form(ENV['RAMEN_LIFF_URL_CREATE'],"入力")
            client.reply_message(event['replyToken'], message)
          when '読み取り','参照','read'
            message = Linemenu.search_form(ENV['RAMEN_LIFF_URL_SEARCH'],"参照")
            client.reply_message(event['replyToken'], message)
          when /【SHARE】/
            keyword = event.message['text']
            pat = /(【.*】)(.*)/
            keyword =~ pat
            share_id = ""
            my_name = ""

            a = Lineuser.all

            # シェアする相手のuseridを取得
            a.map do |v|
              response = client.get_profile(v.userid)
              case response
              when Net::HTTPSuccess then
                contact = JSON.parse(response.body)
                if $2 == contact['displayName']
                  share_id = v.userid
                  break
                end
              else
                p "#{response.code} #{response.body}"
              end
            end

            # シェアする人のnameを取得
            response = client.get_profile(user_id)
            case response
            when Net::HTTPSuccess then
              contact = JSON.parse(response.body)
              my_name =  contact['displayName']
            else
              p "#{response.code} #{response.body}"
            end

            client.push_message(share_id, {
              type: "text",
              text: "#{my_name}さんからシェアされました。"
            })

            message = Temp.find_by_userid(user_id)

            client.push_message(share_id, message.payload)
            Temp.where(userid: user_id).delete_all

          else
            message = {
              type: "text",
              text: event["message"]["text"]
            }

            client.reply_message(event['replyToken'], message)
          end
        end
      when Line::Bot::Event::Postback
        case events[0]["postback"]["data"]
        when "share"
          user_list = [{}]
          a = Lineuser.all

          a.map do |v|
            response = client.get_profile(v.userid)
            case response
            when Net::HTTPSuccess then
              contact = JSON.parse(response.body)
              user_list.push({name:contact['displayName'],url:contact['pictureUrl']})
            else
              p "#{response.code} #{response.body}"
            end
          end
          user_list.shift

          message = Linemenu.share_reply(user_list)

          client.push_message(user_id, message)
        else

        end

      when Line::Bot::Event::Follow
         lineuser = Lineuser.new(userid: user_id)
         lineuser.save

       # ブロックされた時の処理
       when Line::Bot::Event::Unfollow
         Lineuser.where(userid: user_id).delete_all
      end
    }

    head :ok
  end

  def show
    user_id = params["foodrecord"]["lineuser_id"]
    result = Foodrecord.food_search(
      lineuser_id:      user_id,
      store_name:       params["foodrecord"]["store_name"],
      menu_name:        params["foodrecord"]["menu_name"],
      taste:            params["foodrecord"]["taste"],
      thickness:        params["foodrecord"]["thickness"],
      hardness:         params["foodrecord"]["hardness"],
      taste_intensity:  params["foodrecord"]["taste_intensity"],
      evalute:          params["foodrecord"]["evalute"]
    )

    message = Linemenu.search_result(result)
    Temp.create(
      userid:user_id,
      payload:message[1]
    )

    client.push_message(user_id, message[0])
  end

  def search
  end

  def new
  end

  def create
    @food = Foodrecord.new(user_params)
    if @food.save
      redirect_to new_path, notice: "登録が完了しました"
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:foodrecord).permit(:store_name,:menu_name, :taste, :thickness,
                                   :hardness,:taste_intensity,:evalute,:lineuser_id,:picture)
    end

    def set_food
      @food = Foodrecord.new
    end

end
