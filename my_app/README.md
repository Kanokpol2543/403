myapp
├── .dart_tool
├── android
├── assets
│   └── chilies.jpg
├── build
├── ios
├── lib
│   └── main.dart
├── linux
├── macos
├── server
│   ├── node_modules
│   ├── requirment
│   │   ├── requirements.txt
│   │   └── pythonPack.txt
│   ├── app.js
│   ├── label.txt
│   ├── package-lock.json
│   ├── package.json
│   ├── system.py
│   ├── VGG-16_weigths.h5
│   ├── VGG-16.h5
│   └── yoloV5x.pt
├── test
├── web
├── windows
├── .flutter-plugins
├── .flutter-plugins-dependencies
├── .gitignore
├── .gitignore
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
└── README.md

# 📝 การติดตั้งแอปพลิเคชัน

## 📌 สิ่งที่จำเป็น
1. `python`
2. `flutter`
3. `nodeJS` 
4. `android emulation`

![](https://i.imgur.com/waxVImv.png)

## 🔍 ขั้นตอนการดาวน์โหลดซอร์สโค้ด

### 🔸 git Cloning  

1. Cloning แอปพลิเคชัน

        git clone https://github.com/Kanokpol2543/403.git

2. เข้าไปยังแอปพลิเคชัน

        cd my_app

![](https://i.imgur.com/waxVImv.png)

## ⚙️ ขั้นตอนการติดตั้งแอปพลิเคชัน

1. ดาวน์โหลดส่วนของเซิร์ฟเวอร์ลงในที่อยู่ของแอปพลิจากที่อยู่ลิงค์ https://tuipied-my.sharepoint.com/:f:/g/personal/kanokpol_sae_dome_tu_ac_th/EvLsUYidq4JLlkNK1icX95sBbT29wef4hq5ivv7c6HO_wA?e=pXInGG
2. ทำการแตกไฟล์ `zip` แล้วคัดลอกโฟล์เดอร์ server ไปยังที่อยู่ของแอปพลิเคชัน
3. ติดตั้ง `Package` ที่จำเป็น

        cd server/requirement
      
        pip install -r requirements.txt
        
        pip install -r pythonPack.txt

4. เปิดใช้งานเซิร์ฟเวอร์

        cd server
 
        npm run dev
        
5. ติดตั้งติดตั้ง `Package` ที่จำเป็นสำหรับแอปพลิเคชัน
        
        flutter doctor -v
        
        flutter pub get

6. เปิดใช้งานโปรแกรมจำลอง `android emulator` 
7. รันแอปพลิเคชัน

        cd my_app 
        
        flutter run

![](https://i.imgur.com/waxVImv.png)
