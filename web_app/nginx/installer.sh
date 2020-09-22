apt-get update && apt-get install apache2-utils -y

# on ajoute un certificat ssl
openssl req -x509 -nodes -days 365 -subj '/C=FR/ST=Chnord/L=Lille/CN=www.monsupersite.com' \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

# on crée un groupe Diffie-Hellman pour augmenter le niveau de sécurité
openssl dhparam -out /etc/nginx/dhparam.pem 1024 # 4096 recommandé car plus sécurisé

# on rajoute des pointeurs pour récupérer la clé SSL et le certificat
mkdir /etc/nginx/snippets
touch /etc/nginx/snippets/self-signed.conf
echo "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;" >>/etc/nginx/snippets/self-signed.conf
echo "ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" >>/etc/nginx/snippets/self-signed.conf

# mise en place de la configuration du ssl.
# création du fichier de configuration
touch /etc/nginx/snippets/ssl-params.conf
# definition du protocole
echo "ssl_protocols TLSv1.2;" >>/etc/nginx/snippets/ssl-params.conf
# donne la  possibilité au serveur de définir le type de cryptographie
echo "ssl_prefer_server_ciphers on;" >>/etc/nginx/snippets/ssl-params.conf
# emplacement de la clé de chiffrement
echo "ssl_dhparam /etc/nginx/dhparam.pem;" >>/etc/nginx/snippets/ssl-params.conf
# définition des types de cryptographie
echo "ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;" >>/etc/nginx/snippets/ssl-params.conf
# définition de la courbe pour les échanges de clés (fonction math pour la crypto)
echo "ssl_ecdh_curve secp384r1;" >>/etc/nginx/snippets/ssl-params.conf
# définition de la durée de vie de la session ssl
echo "ssl_session_timeout  10m;" >>/etc/nginx/snippets/ssl-params.conf
# paramètrage du cache  shared:name:size
echo "ssl_session_cache shared:SSL:10m;" >>/etc/nginx/snippets/ssl-params.conf
# définition de l'utilisation des tickets
echo "ssl_session_tickets off;" >>/etc/nginx/snippets/ssl-params.conf
# activation de la vérification de la validité du certif par le client
echo "ssl_stapling on;" >>/etc/nginx/snippets/ssl-params.conf
# activation de la vérification de la validité du certif par le serveur
echo "ssl_stapling_verify on;" >>/etc/nginx/snippets/ssl-params.conf
# définition d'un serveur DNS valisant l'authenticité du certificat
echo "resolver 8.8.8.8 8.8.4.4 valid=300s;" >>/etc/nginx/snippets/ssl-params.conf
# délai max de connexion au dns
echo "resolver_timeout 5s;" >>/etc/nginx/snippets/ssl-params.conf
# activation de la protection contre l'affichage de site dans le site (<frame> <iframe>)
echo "add_header X-Frame-Options DENY;" >>/etc/nginx/snippets/ssl-params.conf
# activation de la protection contre Drive-by-download
echo "add_header X-Content-Type-Options nosniff;" >>/etc/nginx/snippets/ssl-params.conf
# activation de la protection contre le xss
echo "add_header X-XSS-Protection '1; mode=block';" >>/etc/nginx/snippets/ssl-params.conf
