./script.sh
for archivoActual in $(ls tests/success);do
	clear
	echo "----------------------------PROGRAMA OK-------------------------------------"
	echo "Corriendo "$archivoActual
    ./a.out tests/success/$archivoActual
    echo "----------------------------------------------------------------------------"
    read -p "Precione cualquier tecla para seguir"

done

for archivoActual in $(ls tests/fails);do
	clear
	echo "---------------------------CON  ERRORES-------------------------------------"
	echo "Corriendo "$archivoActual
    ./a.out tests/fails/$archivoActual
    echo "----------------------------------------------------------------------------"
    read -p "Precione cualquier tecla para seguir"

done