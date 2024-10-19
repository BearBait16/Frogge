from pymongo import MongoClient
import gridfs
import os

# MongoDB connection details
username = 'jacksonaden'
password = '0Rypo9U3PAYgZxIl'
cluster_address = 'images.dd8cd.mongodb.net'
db_name = 'FROGGE_DB'  # Fixed the space issue in the database name
connection_string = f'mongodb+srv://{username}:{password}@{cluster_address}/{db_name}?retryWrites=true&w=majority'

# Create a MongoClient
client = MongoClient(connection_string)
db = client[db_name]

def download_gif(file_id, download_path):
    fs = gridfs.GridFS(db)
    file_data = fs.get(file_id)
    with open(download_path, 'wb') as file:
        file.write(file_data.read())
        print(f'Downloaded file to {download_path}')

# Example usage
if __name__ == "__main__":
    # Replace this with the actual file_id you want to download
    file_id = 'your_file_id_here'  # Replace with the actual file ID or retrieve it from the database
    download_gif(file_id, 'downloaded_file.gif')  # Ensure the path is correct
