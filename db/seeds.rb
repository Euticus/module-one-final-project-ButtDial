u1 = User.create(username: "mrnekketsu")
u2 = User.create(username: "ohnickmoy")
u3 = User.create(username: "widersnyder")

r1 = Restaurant.create(name: "Wok Wok", location: "11 Mott St, New York, NY 10013")
r2 = Restaurant.create(name: "Wonton Noodle Garden", location: "56 Mott St, New York, NY 10013")
r3 = Restaurant.create(name: "Nong's Khao Man Gai", location: "417 SW 13th Ave, Portland, OR 97205")

prng = Random.new

bc1 = BathroomCode.create(bathroom_code: prng.rand(00001..99999), description: "IT REALLY STINKS IN HERE", user_id: u1.id, restaurant_id: r1.id)
bc2 = BathroomCode.create(bathroom_code: prng.rand(00001..99999), description: "Hey, not bad!", user_id: u2.id, restaurant_id: r2.id)
bc3 = BathroomCode.create(bathroom_code: prng.rand(00001..99999), description: "mm, so-so, but at least they don't change the codes often", user_id: u3.id, restaurant_id: r3.id)