import * as functions from "firebase-functions";
import * as admin from "firebase-admin"
import { convertTableFromDB, convertTablesFromDB, TableModel } from "./model/table_model";
import { convertReservationFromDB, ReservationModel } from "./model/reservation_model";
import { ReservationDoneModel } from "./model/reservation_done_model";
import { BillModel, convertBillsFromDB } from "./model/bill_model";
import { convertOrderFromDB } from "./model/order_model";
import { convertProductFromDB } from "./model/product_model";

admin.initializeApp();
const db = admin.firestore();

export const newReservation = functions.firestore
  .document('restaurants/{restaurantId}/queue/{queueId}')
  .onCreate(verifyTables);

export const tableFree = functions.firestore
  .document('restaurants/{restaurantId}/tables/{tableId}')
  .onUpdate(verifyQueue);

export const createBill = functions.firestore
  .document('orders/{orderId}').onCreate(updateTableBill);

export const updateBill = functions.firestore
  .document('orders/{orderId}').onDelete(updateTableBill);

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
    batch.set(table, { reservationId: nextReservation.reservationId, busy: true }, { merge: true });
    // REMOVER O RESERVATIONID DA QUEUE    
    batch.delete(reservationInQueue);
    // ATUALIZAR STATUS DA RESERVATION NA COLLECTION RESERVATIONS
    batch.set(reservationForUpdate, {status: "AGUARDANDO"}, { merge: true })

    await batch.commit();
    return await sendMessage(nextReservation.reservationId);
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

  if (nextReservation.reservationId && nextReservation.tableId) {
    var queueIdToDelete = (await db.collection(`restaurants/${restaurantId}/queue`).where("reservationId", "==", nextReservation.reservationId).get()).docs[0].id;
    
    var batch = db.batch();
    
    // recupera a mesa a ser preenchida
    var table = db.doc(`restaurants/${restaurantId}/tables/${nextReservation.tableId}`);
    // recupera a reserva que será removida da fila
    var reservationInQueue = db.doc(`restaurants/${restaurantId}/queue/${queueIdToDelete}`);
    // recupera a reserva para atualizar o status
    var reservationForUpdate = db.doc(`reservations/${nextReservation.reservationId}`);

    // SETAR O RESERVATIONID NA MESA DEFINIDA.
    batch.set(table, { reservationId: nextReservation.reservationId, busy: true }, { merge: true });
    // REMOVER O RESERVATIONID DA QUEUE    
    batch.delete(reservationInQueue);
    // ATUALIZAR STATUS DA RESERVATION NA COLLECTION RESERVATIONS
    batch.set(reservationForUpdate, {status: "AGUARDANDO"}, { merge: true })

    await batch.commit();
    return await sendMessage(nextReservation.reservationId);    
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

  reservationList.forEach(r => {
    console.log("quantidade mesa: "+r.occupationQty)
  });
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
    const queue = queueList.docs[index];
    var reservationId = queue.data()["reservationId"];
    var reservationFromDB = await db.collection('reservations').doc(reservationId).get();
    var reservation: ReservationModel = convertReservationFromDB(reservationFromDB);
    reservations.push(reservation);
  }
  
  return reservations;
}

async function sendMessage(reservationId: string) {
  try {
    var reservationFromDB = await db.collection(`reservations`).doc(reservationId).get();
    var reservation = convertReservationFromDB(reservationFromDB);
    var user = await db.collection(`users`).doc(reservation.userId).get();

    if (user.data()) {
      var usertokenMessage = user.data()!["tokenMessage"];
      if (usertokenMessage) {
        const payload = {
          notification: {
            title: "Sua mesa já está disponível!",
            body: "Entre no aplicativo e verifique sua reserva."
          }
        };
        return await admin.messaging().sendToDevice(usertokenMessage, payload).then((resp) => {
          console.log(resp);
        }).catch((error) => {
          console.log(error);
        });
      }
    }
    return null;
  } catch (error) {
    return null;    
  }
}

async function updateTableBill(snap: any, context: any) {
  try {
    var bill = new BillModel();
    
    var reservationId = snap.data().reservationId;
    var reservation = convertReservationFromDB(await db.collection(`reservations`).doc(reservationId).get());
    var orderId = context.params.orderId;

    // recupera order a ser inserida
    var order = await GetOrder(orderId, reservation);
    // verifica se existe bill pra essa reserva
    var existBill = await GetExistingBill(reservation.id);

    // se não tiver cria 
    if (existBill == null) {
      bill.reservationId = reservationId; 
      bill.total = order.total;
    } else { // se tiver atualiza 
      bill = existBill;
      bill.total += order.total;
    }

    // atualiza o valor da 
    if (existBill == null) {
      await InsertBill(bill);
    } else {
      await UpdateBill(bill);
    }

    return null;
  } catch (error) {
    return null;
  }
}

async function GetExistingBill(reservationId: string) {
  var billsFromDB = await db.collection('bills').where('paid', "==", false).get();
  var bills = convertBillsFromDB(billsFromDB);
 
  var existingBill = bills.find(b => b.reservationId == reservationId);
  
  return existingBill ?? null;
}

async function GetOrder(orderId: string, reservation: ReservationModel) {
  var order = convertOrderFromDB(await db.collection('orders').doc(orderId).get());

  var product = convertProductFromDB(await db.collection('products').doc(order.productId).get());

  order.total = order.quantity * product.price;

  return order;
}

async function InsertBill(bill: BillModel) {
  await db.collection('bills').add({
    'asked': bill.asked,
    'paid': bill.paid,
    'reservationId': bill.reservationId,
    'total': bill.total,
    'paymentType': ""
  });
}

async function UpdateBill(bill: BillModel) {
  await db.collection('bills').doc(bill.id).update({
    'total': bill.total
  });
}