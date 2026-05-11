from app import app, db, Usuario, Cartera, Transaccion

with app.app_context():
    usuario = Usuario.query.filter_by(email='admin@admin.es').first()
    if usuario:
        cartera = Cartera.query.filter_by(usuario_id=usuario.id).first()
        if cartera:
            # Eliminar transacciones de EUR
            Transaccion.query.filter_by(cartera_id=cartera.id, accion_simbolo='EUR').delete()
            # Añadir 2000 al saldo
            cartera.saldo += 2000
            db.session.commit()
            print("Saldo actualizado y transacciones EUR eliminadas.")
        else:
            print("Cartera no encontrada")
    else:
        print("Usuario no encontrado")