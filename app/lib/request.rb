class Request
  attr_accessor :users,:client,:share_name
  def initialize(client:, users:, share_name: "")
    @client = client
    @users = users
    @share_name = share_name
  end

  # シェアIDを返すメソッド
  def share_id
    share_id = ""
    users.map do |v|
      response = client.get_profile(v.userid)
      case response
      when Net::HTTPSuccess then
        contact = JSON.parse(response.body)
        if share_name == contact['displayName']
          share_id = v.userid
          return share_id
        end
      else
        p "#{response.code} #{response.body}"
      end
    end
  end

  # シェアする相手のlinenameを取得。
  def my_name(user_id)
    response = client.get_profile(user_id)
    case response
    when Net::HTTPSuccess then
      contact = JSON.parse(response.body)
      my_name =  contact['displayName']
      return my_name
    else
      p "#{response.code} #{response.body}"
    end
  end

  # lineuserテーブルに格納されているユーザの情報を取得
  def user_list
    user_list = []
    users.map do |v|
      response = client.get_profile(v.userid)
      case response
      when Net::HTTPSuccess then
        contact = JSON.parse(response.body)
        user_list.push({name:contact['displayName'],url:contact['pictureUrl']})
      else
        p "#{response.code} #{response.body}"
      end
    end
    return user_list
  end

end
