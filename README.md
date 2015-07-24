##drupal-apache Dockerfile

1. Clona el repositorio.
2. si tienes tu ssh key puedes saltarte este paso si no puedes visitar este link https://help.github.com/articles/generating-ssh-keys/
3. Copia tu id_rsa.pub a la carpeta ssh para que puedas autenticarte en el container via ssh una ves que construyas la imagen.
4. Puedes cambiar la configuracion del virtual host de apache editando el archivo drupal.conf que se encuentra en la carpeta apache-conf
5. Para construir la imagen debes correr el siguiente comando desde el directorio root del repositorio: docker build -t [usuario]/[nombre-imagen] .
6. Para crear un container: docker run -p 2224:22 -p 80:80 -v [directorio del codigo drupal]:/home/www -d [usuario]/[nombre-imagen]

**Nota:** los numeros de puerto que se exponen en el ultimo comando los puedes cambiar como mejor te funcionen, ejemplo si quieres que ssh se ejecute en el puerto 3000 de la maquina host seria -p 3000:22
