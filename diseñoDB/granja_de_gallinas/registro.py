def ShowProduction():
    import pymysql
    db = pymysql.connect(host="localhost", user="granja_John", passwd="1234", db="granja")
    # Preparamos un objeto cursor mediante el método cursor()
    cursor = db.cursor()
    # Preparamos la consulta SQL a realizar.
    sql = "SELECT * FROM PRODUCCIONDIARIA"
    try:
        # Ejecutamos el comando SQL
        cursor.execute(sql)
        # Cargamos el resultado en una lista de listas.
        results = cursor.fetchall()
        for row in results:
            producto_id = row[0]
            hblanco_id = row[1]
            hamarillo_id = row[2]
            cantidad_total = row[3]
            fecha = row[4]
            # Now print fetched result
            # %d (int)
            # %s (str)
            print("Producto ID = %d, Huevos Blancos = %s, Huevos Amarillos = %s, Cantidad Total = %s, Fecha = %s" % \
                  (producto_id, hblanco_id, hamarillo_id, cantidad_total, fecha))
    except:
        print("Error: no se encontraron datos")


def BDInsertValueProduc(producto_id, hblanco_id, hamarillo_id, cantidad_total, fecha):
    import pymysql
    db = pymysql.connect(host="localhost", user="granja_John", passwd="1234", db="granja")
    cursor = db.cursor()
    # ejecutamos una consulta SQL query con el método execute().
    cursor.execute(f"INSERT into PRODUCCIONDIARIA Values ({producto_id} ,{hblanco_id}, {hamarillo_id}, {cantidad_total}, "
                   f"{fecha});")
    db.commit()
    print("Producción Diaria Actualizada!")
    db.close()



# def Huevos_blancos(cant_dia):
#     import pymysql
#     db = pymysql.connect(host="localhost", user="granja_John", passwd="1234", db="granja")
#     cursor = db.cursor()
#     # ejecutamos una consulta SQL query con el método execute().
#     cursor.execute(f"INSERT into Huevos_blancos Values ({cant_dia});")
#     db.commit()
#     print("Huevos blancos agregados!")
#     db.close()


# def Huevos_amarillos(cant_dia):
#     import pymysql
#     db = pymysql.connect(host="localhost", user="granja_John", passwd="1234", db="granja")
#     cursor = db.cursor()
#     # ejecutamos una consulta SQL query con el método execute().
#     cursor.execute(f"INSERT into Huevos_amarillos Values ({cant_dia});")
#     db.commit()
#     print("Huevos amarillos agregados!")
#     db.close()

def ShowOrder():
    import pymysql
    db = pymysql.connect(host="localhost", user="granja_John", passwd="1234", db="granja")
    # Preparamos un objeto cursor mediante el método cursor()
    cursor = db.cursor()
    # Preparamos la consulta SQL a realizar.
    sql = "SELECT * FROM PRODUCCIONDIARIA"
    try:
        # Ejecutamos el comando SQL
        cursor.execute(sql)
        # Cargamos el resultado en una lista de listas.
        results = cursor.fetchall()
        for row in results:
            producto_id = row[0]
            hblanco_id = row[1]
            hamarillo_id = row[2]
            cantidad_total = row[3]
            fecha = row[4]
            # Now print fetched result
            # %d (int)
            # %s (str)
            print("Producto ID = %d, Huevos Blancos = %s, Huevos Amarillos = %s, Cantidad Total = %s, Fecha = %s" % \
                  (producto_id, hblanco_id, hamarillo_id, cantidad_total, fecha))
    except:
        print("Error: no se encontraron datos")


def GenerateMaple(hblanco, hamarillo, cant_maple):
    import pymysql
    db = pymysql.connect(host="localhost", user="granja_John", passwd="1234", db="granja")
    cursor = db.cursor()
    # ejecutamos una consulta SQL query con el método execute().
    cursor.execute(f"INSERT into Maple Values ({hblanco}, {hamarillo}, {cant_maple});")
    db.commit()
    print("Maple Creado!")
    db.close()

Id = "NULL"
            # Id = int(input("Insertar ID de personal: ")) #2
            Nombre = str(input("Insertar Nombre de personal: "))  # Josefo
            Apellido = str(input("Insertar Apellido de personal: "))  # Martinez
            Domicilio = str(input("Insertar Domicilio de personal: "))  # Barcala 14
            Telefono = str(input("Insertar Telefono de personal: "))  # 2604435213

            BDInsertValueProduc(Id, "'" + Nombre + "'", "'" + Apellido + "'", "'" + Domicilio + "'", "'" + Telefono + "'")
            # BDInsertValue(3 ,"'Josefo'", "'Martinez'", "'Barcala 14'", "'2604435213'")


def Menu():
    # ╔══╦══╗
    # ║  ║  ║
    # ╠══╬══╣
    # ║  ║  ║
    # ╚══╩══╝
    print("╔═════════════════════════════╗")
    print("║        JOHN'S FARM          ║")
    print("╠═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═╣")
    print('║                     ,.      ║')
    print("║                    (\(\)    ║")
    print("║    ,_              ;  o >   ║")
    print("║     {`-.          /  (_)    ║")
    print("║      `={\`-._____/`   |     ║")
    print("║      `-{ /    -=`\   |      ║")
    print("║    .='`={  -= = _/   /`'-.  ║")
    print("║  (M==M=M==M=M==M==M==M==M)  ║")
    print("║   \=N=N==N=N==N=N==N=NN=/   ║")
    print("║    \M==M=M==M=M==M===M=/    ║")
    print("║     \M==M=M==M=M==M=M=/     ║")
    print("║      \M==M==M=M==M==M/      ║")
    print("║       `-------------'       ║")
    print("║          Main Menu          ║")
    print("╠═════════════════════════════╣")
    print("║  1. Produccion Diaria       ║")
    print("║  2. Pedidos                 ║")
    print("║  3. Cerrar Programa         ║")
    print("╚═════════════════════════════╝")

def MenuProduction():
    # ╔══╦══╗
    # ║  ║  ║
    # ╠══╬══╣
    # ║  ║  ║
    # ╚══╩══╝
    print("╔═════════════════════════════╗")
    print("║        JOHN'S FARM          ║")
    print("╠═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═╣")
    print('║                     ,.      ║')
    print("║                    (\(\)    ║")
    print("║    ,_              ;  o >   ║")
    print("║     {`-.          /  (_)    ║")
    print("║      `={\`-._____/`   |     ║")
    print("║      `-{ /    -=`\   |      ║")
    print("║    .='`={  -= = _/   /`'-.  ║")
    print("║  (M==M=M==M=M==M==M==M==M)  ║")
    print("║   \=N=N==N=N==N=N==N=NN=/   ║")
    print("║    \M==M=M==M=M==M===M=/    ║")
    print("║     \M==M=M==M=M==M=M=/     ║")
    print("║      \M==M==M=M==M==M/      ║")
    print("║       `-------------'       ║")
    print("║     Daily Production Menu   ║")
    print("╠═════════════════════════════╣")
    print("║  1. Actualizar la           ║")
    print("║     produccion de hoy       ║")
    print("║  2. Ver la produccion       ║")
    print("║  3. Volver a menu           ║")
    print("╚═════════════════════════════╝")


def MenuOrders():
    # ╔══╦══╗
    # ║  ║  ║
    # ╠══╬══╣
    # ║  ║  ║
    # ╚══╩══╝
    print("╔═════════════════════════════╗")
    print("║        JOHN'S FARM          ║")
    print("╠═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═╣")
    print('║                     ,.      ║')
    print("║                    (\(\)    ║")
    print("║    ,_              ;  o >   ║")
    print("║     {`-.          /  (_)    ║")
    print("║      `={\`-._____/`   |     ║")
    print("║      `-{ /    -=`\   |      ║")
    print("║    .='`={  -= = _/   /`'-.  ║")
    print("║  (M==M=M==M=M==M==M==M==M)  ║")
    print("║   \=N=N==N=N==N=N==N=NN=/   ║")
    print("║    \M==M=M==M=M==M===M=/    ║")
    print("║     \M==M=M==M=M==M=M=/     ║")
    print("║      \M==M==M=M==M==M/      ║")
    print("║       `-------------'       ║")
    print("║          Orders Menu        ║")
    print("╠═════════════════════════════╣")
    print("║  1. Agregar pedido          ║")
    print("║  2. Ver Pedidos             ║")
    print("║  3. Volver a menu           ║")
    print("╚═════════════════════════════╝")


def RunProgram():
    answer = int()
    while True:

        Menu()

        answer = int(input("Insertar acción segun tabla: "))

        if answer == 1:

            Id = "NULL"
            # Id = int(input("Insertar ID de personal: ")) #2
            Nombre = str(input("Insertar Nombre de personal: "))  # Josefo
            Apellido = str(input("Insertar Apellido de personal: "))  # Martinez
            Domicilio = str(input("Insertar Domicilio de personal: "))  # Barcala 14
            Telefono = str(input("Insertar Telefono de personal: "))  # 2604435213

            BDInsertValueProduc(Id, "'" + Nombre + "'", "'" + Apellido + "'", "'" + Domicilio + "'", "'" + Telefono + "'")
            # BDInsertValue(3 ,"'Josefo'", "'Martinez'", "'Barcala 14'", "'2604435213'")
        elif answer == 2:
            ShowProduction()
        elif answer == 3:
            print("Cerrando programa...")
            break
        else:
            print("Valor ingresado incorrecto.")


RunProgram()
