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

def upload_gif(file_path):
    fs = gridfs.GridFS(db)
    with open(file_path, 'rb') as file:
        file_id = fs.put(file, filename=os.path.basename(file_path))
        print(f'Uploaded {file_path} with id {file_id}')
        return file_id

def download_gif(file_id, download_path):
    fs = gridfs.GridFS(db)
    file_data = fs.get(file_id)
    with open(download_path, 'wb') as file:
        file.write(file_data.read())
        print(f'Downloaded file to {download_path}')

# Example usage
if __name__ == "__main__":
    # Uploading a GIF
    file_id = upload_gif('Tadpol_big-export.gif')  # Ensure the path is correct

    # Downloading the same GIF
    download_gif(file_id, 'downloaded_file.gif')  # Ensure the path is correct

"""
commands to download propper libraries

pip install pymongo gridfs


"""