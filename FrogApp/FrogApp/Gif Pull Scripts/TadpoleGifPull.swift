// New function to download the GIF and return its data

// Example usage

import BSON

import MongoSwift

func fetchGif(fileId: ObjectId) async throws -> Data {
    // MongoDB connection details
    let username = "jacksonaden"
    let password = "0Rypo9U3PAYgZxIl"
    let clusterAddress = "images.dd8cd.mongodb.net"
    let dbName = "FROGGE_DB"

    // Create a connection string
    let connectionString =
        "mongodb+srv://\(username):\(password)@\(clusterAddress)/\(dbName)?retryWrites=true&w=majority"

    // Create a MongoDB client
    let client = try MongoClient(connectionString)
    let database = client.db(dbName)
    let gridFS = GridFS(database: database)

    // Fetch the file from GridFS
    let file = try await gridFS.findOne(filter: ["_id": .objectId(fileId)])

    guard let fileData = file?.data else {
        throw NSError(
            domain: "FetchGifError", code: 404,
            userInfo: [NSLocalizedDescriptionKey: "File not found"])
    }

    return fileData
}
func downloadGif(fileId: ObjectId) async throws -> Data {
    let gifData = try await fetchGif(fileId: fileId)
    print("GIF fetched successfully.")
    return gifData
}
Task {
    do {
        let fileId = ObjectId("67135b3a9681bcf34318f06f")  // Replace with your actual file ID
        let gifData = try await downloadGif(fileId: fileId)

        // You can now use gifData as needed, for example, display it in a UIImageView
        // Assuming you have a UIImageView named imageView
        if let imageView = imageView {
            imageView.image = UIImage(data: gifData)
        }

        print("GIF data ready for use.")
    } catch {
        print("Error fetching GIF: \(error)")
    }
}
