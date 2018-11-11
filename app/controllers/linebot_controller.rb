class LinebotController < ApplicationController
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

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when '入力','write'
            menu = Linemenu.new
            message = menu.get_search_form
            # message = {
            #   type: 'text',
            #   text: 'write'
            # }
            client.reply_message(event['replyToken'], message)
          when '読み取り','参照','read'
            message = {
              type: 'text',
              text: 'read'
            }
            client.reply_message(event['replyToken'], message)
          end
        end
      when Line::Bot::Event::Follow
         user_id = event["source"]["userId"]
         # unless Lineuser.exists?(userid:user_id)
           lineuser = Lineuser.new(userid: user_id)
           lineuser.save
         # end
       # ブロックされた時の処理
       when Line::Bot::Event::Unfollow
         user_id = event["source"]["userId"]
         Lineuser.where(userid: user_id).delete_all
      end
    }


    head :ok
  end

  def write
  end

end
