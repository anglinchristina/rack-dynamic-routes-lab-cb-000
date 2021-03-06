class Application

  @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]

  # If a user requests /items/<Item Name> it should return the price of that item
  # IF a user requests an item that you don't have, then return a 400 and an error message
  #

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = @@items.find{|i| i.name == item_name}
      if item
        resp.status = 200
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end


    else
      resp.status = 404
      resp.write "Route not found"
    end

    resp.finish

  end

end
