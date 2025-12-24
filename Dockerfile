# Hafif bir Python imajı kullanıyoruz (Slim versiyon)
FROM python:3.10-slim

# Çalışma dizinini ayarla
WORKDIR /app

# Önce gereksinimleri kopyala (Cache optimizasyonu için)
COPY requirements.txt .

# Paketleri yükle (--no-cache-dir imaj boyutunu küçük tutar)
RUN pip install --no-cache-dir -r requirements.txt

# Kalan tüm uygulama kodunu kopyala
COPY . .

# Flask'in çalışacağı portu dışarı aç
EXPOSE 5000

# Uygulamayı Gunicorn ile başlat
# app:app -> (dosya_adi:flask_instance_adi)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]