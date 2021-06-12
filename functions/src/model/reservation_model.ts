export class ReservationModel {
    id:string = "";
    userId:string = "";
    restaurantId: string = "";
    checkIn: Date = new Date;
    occupationQty: number = 0;
    status: ReservationStatus = ReservationStatus.ATIVO;
}

export enum ReservationStatus {
    RESERVADO,
    AGUARDANDO,
    ATIVO,
    FINALIZADO,
    CANCELADO,
  }

export function convertReservationFromDB(reservationFromDB: any) {
    var reservation = new ReservationModel;
  
    if (reservationFromDB) {
        reservation.id = reservationFromDB.id;
        reservation.userId = reservationFromDB.data()["userId"];
        reservation.restaurantId = reservationFromDB.data()["restaurantId"];
        reservation.checkIn = reservationFromDB.data()["checkin"];
        reservation.occupationQty = reservationFromDB.data()["occupationQty"];
        reservation.status = getStatusEnum(reservationFromDB.data()["status"]);
    }
    
    return reservation;
  }

  function getStatusEnum(statusFromDB: string) {
    switch (statusFromDB) {
        case "RESERVADO":
            return ReservationStatus.RESERVADO;
        case "AGUARDANDO":
            return ReservationStatus.AGUARDANDO;
        case "ATIVO":
            return ReservationStatus.ATIVO;
        case "FINALIZADO":
            return ReservationStatus.FINALIZADO;
        case "CANCELADO":
            return ReservationStatus.CANCELADO;
        default:
            return ReservationStatus.ATIVO;
    }
  }