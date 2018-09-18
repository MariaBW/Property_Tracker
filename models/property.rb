require("pg")

class Property

  attr_accessor :address, :value, :bedrooms, :year_built
  attr_reader :id


  def initialize(features)
    @id = features["id"].to_i if features["id"]
    @address = features["address"]
    @value = features["value"].to_i
    @bedrooms = features["bedrooms"].to_i
    @year_built = features["year_built"].to_i
  end

  def save()
    db = PG.connect({dbname: "property_tracker", host: "localhost",})

    sql = "INSERT INTO properties
    (address, value, bedrooms, year_built) VALUES ($1, $2, $3, $4) RETURNING *"

    values = [@address, @value, @bedrooms, @year_built]

    db.prepare("new_entry", sql)
    @id = db.exec_prepared("new_entry", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({ dbname: "property_tracker", host: "localhost"})

    sql = "UPDATE properties SET (address, value, bedrooms, year_built) = ($1, $2, $3, $4) WHERE id = $5"

    values = [@address, @value, @bedrooms, @year_built, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end



  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost",})

    sql = "DELETE FROM properties"

    db.prepare("text", sql)
    db.exec_prepared("text")
    db.close()

  end

  def delete()
    db = PG.connect({ dbname: "property_tracker", host: "localhost"})

    sql = "DELETE FROM properties WHERE id = $1"

    values = [@id]

    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()

  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE id = $1"

    values = [id]

    db.prepare("text", sql)
    result = db.exec_prepared("text", values)
    db.close

    return result.map {|hooses| Property.new(hooses)}

  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE address = $1"

    values = [address]

    db.prepare("text", sql)
    result = db.exec_prepared("text", values)
    db.close

    return result.map {|place| Property.new(place)}

  end


end
