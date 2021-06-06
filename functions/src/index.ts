import * as functions from "firebase-functions";
import * as admin from "firebase-admin"
import { convertTableFromDB, convertTablesFromDB, TableModel } from "./model/table_model";
import { convertReservationFromDB, ReservationModel } from "./model/reservation_model";
import { ReservationDoneModel } from "./model/reservation_done_model";

admin.initializeApp();
const db = admin.firestore();

export const newReservation = functions.firestore
  .document('restaurants/{restaurantId}/queue/{queueId}')
  .onCreate(verifyTables);

export const tableFree = functions.firestore
  .document('restaurants/{restaurantId}/tables/{tableId}')
  .onUpdate(verifyQueue);

async function verifyTables(snap: any, context: any) {
  var nextReservation: ReservationDoneModel;
  const restaurantId = context.params.restaurantId;
  const queueId = context.params.queueId;
  const reservationId = snap.data().reservationId;
  
  // recupera lista de mesa 
  var tablesFromDB = await db.collection(`restaurants/${restaurantId}/tables`).where('busy', "==", false).get();
  var tables = convertTablesFromDB(tablesFromDB);

  if (tables.length == 0) {
    return null;
  }

  // recupera a reserva
  var reservationFromDB = await db.collection('reservations').doc(reservationId).get();
  var reservation = convertReservationFromDB(reservationFromDB);
  var reservations: ReservationModel [] = [];
  reservations.push(reservation);

  // chama método para verificar se tem mesa livre pra reserva
  nextReservation = await runQueue(reservations, tables);

  if (nextReservation.reservationId && nextReservation.tableId) {
    var batch = db.batch();
    
    // recupera a mesa a ser preenchida
    var table = db.doc(`restaurants/${restaurantId}/tables/${nextReservation.tableId}`);
    // recupera a reserva que será removida da fila
    var reservationInQueue = db.doc(`restaurants/${restaurantId}/queue/${queueId}`);
    // recupera a reserva para atualizar o status
    var reservationForUpdate = db.doc(`reservations/${nextReservation.reservationId}`);

    // SETAR O RESERVATIONID NA MESA DEFINIDA.
    batch.set(table, { reservationid: nextReservation.reservationId, busy: true }, { merge: true });
    // REMOVER O RESERVATIONID DA QUEUE    
    batch.delete(reservationInQueue);
    // ATUALIZAR STATUS DA RESERVATION NA COLLECTION RESERVATIONS
    batch.set(reservationForUpdate, {active: false}, { merge: true })

    return await batch.commit();
  }
  else {
    return null;
  }
}

async function verifyQueue(change: any, context: any) {
  var nextReservation: ReservationDoneModel;
  const restaurantId = context.params.restaurantId;
  const tableId = context.params.tableId;

  const oldValue = change.before.exists ? change.before.data() : null;
  const newValue = change.after.exists ? change.after.data() : null;

  if(newValue != null && newValue.busy && !oldValue.busy) {
    return null;
  }
  
  // recupera a mesa 
  var tableFromDB = await db.collection(`restaurants/${restaurantId}/tables`).doc(tableId).get();
  var tempTable = convertTableFromDB(tableFromDB);
  var tables: TableModel[] = [];
  tables.push(tempTable);

  // recupera as reservas da fila
  var reservationsFromQueue = await getReservationsFromQueue(restaurantId);

  if (reservationsFromQueue.length == 0) {
    return null;
  }

  // chama método para verificar se tem mesa livre pra reserva
  nextReservation = await runQueue(reservationsFromQueue, tables);

  var queueIdToDelete = (await db.collection(`restaurants/${restaurantId}/queue`).where("reservationId", "==", nextReservation.reservationId).get()).docs[0].id;

  if (nextReservation.reservationId && nextReservation.tableId) {
    var batch = db.batch();
    
    // recupera a mesa a ser preenchida
    var table = db.doc(`restaurants/${restaurantId}/tables/${nextReservation.tableId}`);
    // recupera a reserva que será removida da fila
    var reservationInQueue = db.doc(`restaurants/${restaurantId}/queue/${queueIdToDelete}`);
    // recupera a reserva para atualizar o status
    var reservationForUpdate = db.doc(`reservations/${nextReservation.reservationId}`);

    // SETAR O RESERVATIONID NA MESA DEFINIDA.
    batch.set(table, { reservationid: nextReservation.reservationId, busy: true }, { merge: true });
    // REMOVER O RESERVATIONID DA QUEUE    
    batch.delete(reservationInQueue);
    // ATUALIZAR STATUS DA RESERVATION NA COLLECTION RESERVATIONS
    batch.set(reservationForUpdate, {active: false}, { merge: true })

    return await batch.commit();
  }
  else {
    return null;
  }
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
  var stop = false;
  tableList.forEach(table => {
    if (stop) return;
    var reservationId = reservationList.find(r => r.occupationQty <= table.capacity)?.id;
    
    if (reservationId != undefined && !stop) {
      stop = true;
      nextReservation.reservationId = reservationId;
      nextReservation.tableId = table.id;
    }
  });

  return nextReservation
}

async function getReservationsFromQueue(restaurantId: string) {
  var queueList = await db.collection(`restaurants/${restaurantId}/queue`).get();
  var reservations: ReservationModel[] = [];
  
  for (let index = 0; index < queueList.docs.length; index++) {
    const table = queueList.docs[index];
    var reservationId = table.data()["reservationId"];
    var reservationFromDB = await db.collection('reservations').doc(reservationId).get();
    var reservation: ReservationModel = convertReservationFromDB(reservationFromDB);
    reservations.push(reservation);
  }
  
  return reservations;
}



