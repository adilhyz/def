import requests
from bs4 import BeautifulSoup
from fake_useragent import UserAgent
from art import *

tprint("SundaXploit V1.2")
print("by t.me/awn_sx")
print("github: https://github.com/AkbarWiraN")

# Meminta input file list dari pengguna
filename = input("Masukkan nama file list: ")

# Membuka file dan membaca baris-barisnya
with open(filename, "r") as f:
    urls = f.readlines()

# Menghapus protokol http dan https dari setiap URL di dalam list
urls = [url.strip().replace("http://", "").replace("https://", "") for url in urls]

# Membuat file baru untuk menyimpan hasil
result_file = open("result.txt", "w")

# Melakukan reverse IP lookup untuk setiap URL
for url in urls:
    # Membuat URL untuk reverse IP lookup
    lookup_url = "https://rapiddns.io/sameip/{}?full=1".format(url)

    # Menentukan user agent secara acak
    ua = UserAgent()
    headers = {'User-Agent': ua.random}

    # Melakukan request ke halaman web dengan user agent acak
    response = requests.get(lookup_url, headers=headers)

    # Mengekstrak domain dari hasil reverse IP lookup
    soup = BeautifulSoup(response.content, "html.parser")
    table = soup.find("table")

    if table:
        rows = table.find_all("tr")[1:]  # melewati header tabel

        domains = [row.find_all("td")[0].text.strip() for row in rows]

        # Filter domain yang tidak diinginkan
        exclude_keywords = ['autodiscover', 'cpanel', 'cpcalendars', 'cpcontact', 'ftp', 'mail', 'ns1', 'ns2', 'ns3', 'ns4', 'webdisk', 'webmail', 'www', 'mx1', 'mx', 'mx2']
        domains = [domain for domain in domains if not any(keyword in domain for keyword in exclude_keywords)]

        # Filter domain yang duplikat
        domains = list(set(domains))

        # Menyimpan hasil ke dalam file
        if domains:
            result_file.write("\n".join(domains) + "\n")
            # Menampilkan pesan bahwa domain telah ditemukan dan hasil telah disimpan
            print(f"{url} found {len(domains)} domain - saved!")
        else:
            print(f"{url} found no domains")
    else:
        print(f"{url} failed to retrieve data")

# Menutup file hasil
result_file.close()

print("Program selesai. Hasil telah disimpan di result.txt.")
