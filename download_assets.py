import csv
import os
import urllib.request
import ssl

# Allow unverified SSL for simplicity
ssl._create_default_https_context = ssl._create_unverified_context

def download_image(url, save_path):
    if not url or url == 'null':
        return
    try:
        # Check if file already exists to avoid re-downloading
        if os.path.exists(save_path):
            print(f"File {save_path} already exists. Skipping.")
            return
            
        print(f"Downloading {url} to {save_path}")
        urllib.request.urlretrieve(url, save_path)
    except Exception as e:
        print(f"Failed to download {url}: {e}")

def main():
    os.makedirs('assets/assets/images/categories', exist_ok=True)
    os.makedirs('assets/assets/images/products', exist_ok=True)

    # Categories
    print("Processing Categories...")
    try:
        with open('temp_data/categories.csv', 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                title = row['title'].strip()
                url = row['img']
                filename = f"{title.replace(' ', '_').replace('/', '_').replace('-', '_').lower()}.avif"
                save_path = os.path.join('assets/assets/images/categories', filename)
                download_image(url, save_path)
    except Exception as e:
        print(f"Error processing categories: {e}")

    # Products
    print("Processing Products...")
    target_items = [
        "Nitro Cold Brew", "Dolce Cold Brew", "Americano", "Caffe Latte", "Caffè Latte",
        "Java Chip Frappuccino", "Cloud Cheese Cake", "Cold Brew", 
        "Espresso", "Frappuccino", "Tea", "Cake", "Sandwich", "Goods"
    ]
    
    try:
        with open('temp_data/products.csv', 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            count = 0
            for row in reader:
                name = row['name'].strip()
                url = row['img']
                
                should_download = False
                # Check for exact or partial matches with targets
                for target in target_items:
                    if target.lower() in name.lower():
                        should_download = True
                        break
                
                # Also download common items to have a good set
                if not should_download and any(x in name.lower() for x in ['latte', 'mocha', 'coffee', 'tea', 'croissant', 'bagel', 'cake', 'muffin', 'scone']):
                     should_download = True

                if should_download:
                    filename = f"{name.replace(' ', '_').replace('/', '_').replace('-', '_').lower()}.avif"
                    save_path = os.path.join('assets/assets/images/products', filename)
                    download_image(url, save_path)
                    count += 1
                    if count >= 50: # Limit to 50 product images to avoid taking too long/space
                        pass 
    except Exception as e:
        print(f"Error processing products: {e}")

if __name__ == "__main__":
    main()
