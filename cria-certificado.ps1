keytool -genkeypair -alias mei-aid-cert -keyalg RSA -keysize 4096 -validity 365 -keystore mei_aid.jks -storepass aluno123 -keypass aluno123 -dname "CN=mei.aid.local, OU=TI, O=IPCB, L=Castelo Branco, ST=Lisboa, C=PT"

keytool -exportcert -alias mei-aid-cert -keystore mei_aid.jks -file mei-aid.cer -storepass aluno123

