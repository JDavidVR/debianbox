Este devbox automatiza la configuracion de un servidor ya sea para magento 2 o magento 1.

Debianbox tiene 2 propositos:
1) Permitir tener un mismo entorno de desarrollo independiente del sistema operativo que usemos.
2) Demostrar los pasos de instalacion de un servidorweb el cual puede ser usado para cualquier servidor debian 9.

## Instrucciones

### Directorios
Este repositorio cuenta con 2 directorios importantes:
projects: aca iran todos los proyectos de magento que queramos usar
vhosts: contiene un script de autoconfiguracion del virtual host

### Configuracion Vagrantfile
Este devbox tiene un archivo preconfigurado "Vagrant.sample", crea un copia del archivo eliminando la extension ".sample".

Ahora que tenemos nuestro Vagrantfile podemos definir las siguientes configuraciones:

Descomentar la opcion para la ruta de nuestros proyectos, usar la opcion que tiene nfs si estas usando mac.
```
  # Projects: Uncomment the one that works for you <---<<
  # config.vm.synced_folder "./projects", "/var/www/projects"
  # config.vm.synced_folder "./projects", "/var/www/projects", type: "nfs"
```

Descomentar el script de auto instalacion deseado (SOLO UNO), ya sea magento 2 o magenot 1.
```
  # First RUN script: Uncomment script you want <---<<
  # config.vm.provision "shell", path: "m2server.sh"
  # config.vm.provision "shell", path: "m1server.sh"
```

Descomentar y definir el numero de nucleos que se desea configurar para el devbox
```
    # Set vBox CPU cores: Uncomment to set own config <---<<
    # vb.cpus = 4
```

Una vez configurado el Vagrantfile ejecutar el comando `vagrant up`
Para acceder por ssh ejecutar el comando `vagrant ssh`

### Configuracion virtualhost
Lo primero es que en projects, en una carpeta nueva tener los archivos de magento, ya sea de github o composer, ejemplo: `projects/m224`

Ahora que ya tenemos un carpeta con archivos de magento debemos crear un copia del archivo que esta dentro de `vhosts/mysite.sh.sample`, para este ejemplo sera `vhosts/m224.sh`

Abrimos el archivo `vhosts/m224.sh` con algun editor de texto y cambiamos la configuracion `site='mysite';` por el nombre del directorio projects `site='m224';`.

Accedemos al devbox con `vagrant ssh` y ejecutamos el comando `sh ~/vhosts/m224.sh`;

Nota el domino por defecto sigue esta regla: [nombre_carpeta].debibox, para ejemplo de arriba sera m224.debibox

Esto configurara de manera automatica todo y lo unico que resta es configurar el dominio del nuevo sitio en nuestro equipo.

Para el caso de linux y mac, `vim /etc/hosts` y agregamos `192.168.33.15	m224.debibox`.

### Importante
Vagrant Box de debian 9 tiene 6.5G de espacio disponible aproximadamente, lo que significa que solo se pueden instalar BD de hasta 6.5GB.

---
**Author: David Velasquez**
[linkedin](https://www.linkedin.com/in/jdavidvr/) | [website](http://jdavidvr.com/) | [twitter](https://twitter.com/jdavidvr) 
