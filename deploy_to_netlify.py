import os
import zipfile
import requests
import sys

def zip_folder(folder_path, zip_name):
    with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(folder_path):
            for file in files:
                # Skip the zip file itself and potential system files
                if file == zip_name or file.startswith('.'):
                    continue
                file_path = os.path.join(root, file)
                # Maintain structure relative to folder_path
                arcname = os.path.relpath(file_path, folder_path)
                zipf.write(file_path, arcname)

def deploy_to_netlify(site_id, zip_path, access_token):
    url = f"https://api.netlify.com/api/v1/sites/{site_id}/deploys"
    headers = {
        "Content-Type": "application/zip",
        "Authorization": f"Bearer {access_token}"
    }
    
    print(f"Deploying {zip_path} to site {site_id}...")
    with open(zip_path, 'rb') as f:
        response = requests.post(url, headers=headers, data=f)
    
    if response.status_code in [200, 201]:
        print("Successfully deployed!")
        print(response.json())
    else:
        print(f"Failed to deploy. Status code: {response.status_code}")
        print(response.text)

if __name__ == "__main__":
    # Site ID and path
    site_id = "7fcc0ba5-c86e-4730-ac20-829372f3949e"
    src_dir = r"D:\AI建站\goodshoe-b2b"
    zip_file = "site_deploy.zip"
    
    # We need the access token from the environment/config
    # I'll check if I can find it or ask for it
    access_token = os.environ.get("NETLIFY_AUTH_TOKEN")
    
    if not access_token:
        print("Error: NETLIFY_AUTH_TOKEN environment variable not set.")
        sys.exit(1)
        
    zip_folder(src_dir, zip_file)
    deploy_to_netlify(site_id, zip_file, access_token)
