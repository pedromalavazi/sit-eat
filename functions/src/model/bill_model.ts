export class BillModel {
    id: string = "";
    asked: boolean = false;
    paid: boolean = false;
    reservationId: string = "";
    total: number = 0;
  }
  
  export function convertBillsFromDB(bills: any) {
    var billList: BillModel[] = [];
    
    if (bills.docs.length > 0) {
      bills.docs.forEach((bill: any) => {
        var tempTable: BillModel = new BillModel();
        tempTable.id = bill.id;
        tempTable.asked = bill.data()["asked"];
        tempTable.paid = bill.data()["paid"];
        tempTable.total = bill.data()["total"];
        tempTable.reservationId = bill.data()["reservationId"];
    
        billList.push(tempTable);
      });
    }
  
    return billList;
  }
  
  export function convertBillFromDB(tableFromDB: any) {
    var bill: BillModel = new BillModel();
  
    if (tableFromDB) {
      bill.id = tableFromDB.id;
      bill.asked = tableFromDB.data()["asked"];
      bill.paid = tableFromDB.data()["paid"];
      bill.total = tableFromDB.data()["total"];
      bill.reservationId = tableFromDB.data()["reservationId"];
    }
  
    return bill;
  }
  