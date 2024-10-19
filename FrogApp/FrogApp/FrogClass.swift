class Frog {
    var eggGif: String
    var eggImage: String
    var tadpoleImage: String
    var tadpoleGif: String
    var frogImage: String
    var frogGif: String

    init(frogImage: String, frogGif: String) {
        self.eggGif = "egg_gif"
        self.eggImage = "egg_still"
        self.tadpoleImage = "tadpole_still"
        self.tadpoleGif = "tadpole_gif"
        self.frogImage = frogImage
        self.frogGif = frogGif
    }

    func frogDeath() {
        print("Frog has died")
    }
}
