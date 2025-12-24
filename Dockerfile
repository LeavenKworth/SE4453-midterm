FROM python:3.10-slim

WORKDIR /app

# 1. SSH Server'ı ve gerekli paketleri kur
RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd \
    && chmod 755 /app

# 2. SSH Konfigürasyonunu Azure'a uygun hale getir (sshd_config)
# Azure App Service SSH için 2222 portunu kullanır.
COPY sshd_config /etc/ssh/

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# 3. Entrypoint scriptine çalıştırma izni ver
RUN chmod +x entrypoint.sh

# 4. Portları dışarı aç
# 5000: Flask Uygulaması
# 2222: Azure Web SSH
EXPOSE 5000 2222

# 5. Başlatma scriptini çalıştır
ENTRYPOINT ["./entrypoint.sh"]