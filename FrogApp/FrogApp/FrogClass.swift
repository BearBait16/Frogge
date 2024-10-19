class Frog {
    var eggGif: String
    var eggImage: String
    var tadpoleImage: String
    var tadpoleGif: String
    var frogImage: String
    var frogGif: String

    init(frogImage: String, frogGif: String) {
        self.eggGif = "frog_gif_1.gif"
        self.eggImage = "egg_still.png"
        self.tadpoleImage = "tadpole_still.png"
        self.tadpoleGif = "Tadpole_big-export.gif"
        self.frogImage = frogImage
        self.frogGif = frogGif
    }

    func frogDeath() {
        print("Frog has died")
    }
}
