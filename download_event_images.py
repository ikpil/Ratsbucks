import os
import urllib.request
import ssl

# Allow unverified SSL for simplicity
ssl._create_default_https_context = ssl._create_unverified_context

def download_image(url, save_path):
    try:
        if os.path.exists(save_path):
            print(f"File {save_path} already exists. Skipping.")
            return
            
        print(f"Downloading {url} to {save_path}")
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response, open(save_path, 'wb') as out_file:
            out_file.write(response.read())
        print(f"Successfully downloaded to {save_path}")
    except Exception as e:
        print(f"Failed to download {url}: {e}")

def main():
    target_dir = 'assets/images/events'
    os.makedirs(target_dir, exist_ok=True)

    images = {
        'strawberry_latte.jpg': 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?q=80&w=600&auto=format&fit=crop',
        'gift_card.jpg': 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?q=80&w=600&auto=format&fit=crop',
        'siren_order.jpg': 'https://images.unsplash.com/photo-1516321497487-e288fb19713f?q=80&w=600&auto=format&fit=crop',
        'tumbler.jpg': 'https://images.unsplash.com/photo-1596073419667-9d77d59f033f?q=80&w=600&auto=format&fit=crop',
        'americano.jpg': 'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=600&auto=format&fit=crop',
    }

    for filename, url in images.items():
        save_path = os.path.join(target_dir, filename)
        download_image(url, save_path)

if __name__ == "__main__":
    main()
