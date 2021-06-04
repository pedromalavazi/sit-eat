import * as functions from "firebase-functions";
import * as admin from "firebase-admin"
import { convertTablesFromDB, TableModel } from "./model/table_model";
import { convertReservationFromDB, ReservationModel } from "./model/reservation_model";
import { ReservationDoneModel } from "./model/reservation_done_model";

admin.initializeApp();
const db = admin.firestore();

export const newReservation = functions.firestore
  .document('restaurants/{restaurantId}/queue/{queueId}')
  .onCreate(verifyTables);

async function verifyTables(snap: any, context: any) {
  var nextReservation: ReservationDoneModel;
  const restaurantId = context.params.restaurantId;
  const reservationId = snap.data().reservationId;
  
  // recupera lista de mesa 
  var tablesFromDB = await db.collection(`restaurants/${restaurantId}/tables`).where('busy', "==", "false").get();
  var tables = convertTablesFromDB(tablesFromDB);

  // recupera a reserva
  var reservationFromDB = await db.collection('reservations').doc(reservationId).get();
  var reservation = convertReservationFromDB(reservationFromDB);
  var reservations: ReservationModel [] = [];
  reservations.push(reservation);

  // chama método para verificar se tem mesa livre pra reserva
  nextReservation = await runQueue(reservations, tables);

  if (nextReservation.reservationId && nextReservation.table) {
    // TODO
    // SETAR O RESERVATIONID NA MESA DEFINIDA.
  }

  console.log(nextReservation);
}

async function runQueue(reservationList: ReservationModel[], tableList: TableModel[]) {
  var nextReservation: ReservationDoneModel = new ReservationDoneModel;

  tableList.sort((a: TableModel, b: TableModel) => {
    if (a.capacity > b.capacity) {
      return 1
    }
    else if (a.capacity < b.capacity) {
      return -1;
    }
    return 0;
  });

  reservationList.sort((a: ReservationModel, b: ReservationModel) => {
    if (a.checkIn > b.checkIn) {
      return 1
    }
    else if (a.checkIn < b.checkIn) {
      return -1;
    }
    return 0;
  });

  tableList.forEach(table => {
    nextReservation.reservationId = reservationList.find(r => r.occupationQty <= table.capacity)?.id;
    nextReservation.table = table.number; 
    return nextReservation;
    // reservationList.forEach(reservation => {
    //   if (reservation.occupationQty <= table.capacity) {
    //     return reservation.id;
    //   }
    // });
  });

  return nextReservation
}



