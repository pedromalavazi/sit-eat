export class ReservationModel {
    id:string = "";
    userId:string = "";
    restaurantId: string = "";
    checkIn: Date = new Date;
    occupationQty: number = 0;
    active: boolean = false;
    canceled: boolean = false;
}

export function convertReservationFromDB(reservationFromDB: any) {
    var reservation = new ReservationModel;
  
    reservation.id = reservationFromDB.id;
    reservation.userId = reservationFromDB.data()["userId"];
    reservation.restaurantId = reservationFromDB.data()["restaurantId"];
    reservation.checkIn = reservationFromDB.data()["checkIn"];
    reservation.occupationQty = reservationFromDB.data()["occupationQty"];
    reservation.canceled = reservationFromDB.data()["canceled"];
    reservation.active = reservationFromDB.data()["active"];
  
    return reservation;
  }