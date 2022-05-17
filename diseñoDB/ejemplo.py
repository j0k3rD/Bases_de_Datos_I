# #!/usr/bin/python3
# def cuenta_registros01():
#     import pymysql
#     # Abrir Conexión a la Base de Datos
#     db = pymysql.connect(host="127.0.0.1", user="pruebas", passwd="Pru-12345", db="pruebas")
#     # Preparar objeto cursor con el método cursor()
#     cursor = db.cursor()
#     # ejecutamos una consulta SQL query con el método execute().
#     cursor.execute("SELECT count(*) from Personal")
#     # Obtenemos resultado de una fila con el método fetchone().
#     data = cursor.fetchone()
#     print("Nro de Registros en Personal: %s " % data)
#     # nos desconectamos del servidor
#     db.close()
#
#
# cuenta_registros01()

def ShowTable():
    import pymysql
    db = pymysql.connect(host="localhost", user="pruebas", passwd="Pru-12345", db="pruebas")
    # Preparamos un objeto cursor mediante el método cursor()
    cursor = db.cursor()
    # Preparamos la consulta SQL a realizar.
    sql = "SELECT * FROM PERSONAL"
    try:
        # Ejecutamos el comando SQL
        cursor.execute(sql)
        # Cargamos el resultado en una lista de listas.
        results = cursor.fetchall()
        for row in results:
            personal_id = row[0]
            nombre = row[1]
            apellido = row[2]
            domicilio = row[3]
            telefono = row[4]
            # Now print fetched result
            # %d (int)
            # %s (str)
            print("Personal ID = %d, Nombre = %s, Apellido = %s, Domicilio = %s, Teléfono = %s" % \
                  (personal_id, nombre, apellido, domicilio, telefono))
    except:
        print("Error: no se encontraron datos")


def BDInsertValue(personal_id, nombre, apellido, domicilio, telefono):
    import pymysql
    # Abrir Conexión a la Base de Datos
    db = pymysql.connect(host="localhost", user="pruebas", passwd="Pru-12345", db="pruebas")
    # Preparar objeto cursor con el método cursor()
    # Esto es para ejecutar comandos dentro de la consola.
    cursor = db.cursor()
    # ejecutamos una consulta SQL query con el método execute().
    cursor.execute(f"INSERT into PERSONAL Values ({personal_id} ,{nombre}, {apellido}, {domicilio}, {telefono});")

    # Obtenemos resultado de una fila con el método fetchone().
    # data = cursor.fetchone()
    # Realiza los cambios dentro de la base de datos.
    db.commit()
    print("Insertado con exito los datos de la persona")
    # nos desconectamos del servidor
    db.close()


def Menu():
    # ╔══╦══╗
    # ║  ║  ║
    # ╠══╬══╣
    # ║  ║  ║
    # ╚══╩══╝
    print("╔════════════════════════════╗")
    print("║      Menu de Selección     ║")
    print("╠════════════════════════════╣")
    print("║1. Insertar valores a tabla ║")
    print("║2. Mostrar Tabla            ║")
    print("║3. Cerrar Programa          ║")
    print("╚════════════════════════════╝")


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

            BDInsertValue(Id, "'" + Nombre + "'", "'" + Apellido + "'", "'" + Domicilio + "'", "'" + Telefono + "'")
            # BDInsertValue(3 ,"'Josefo'", "'Martinez'", "'Barcala 14'", "'2604435213'")
        elif answer == 2:
            ShowTable()
        elif answer == 3:
            print("Cerrando programa...")
            break
        else:
            print("Valor ingresado incorrecto.")


RunProgram()
