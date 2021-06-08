export class TableModel {
  id: string = "";
  busy: boolean = false;
  number: number = 0;
  capacity: number = 0;
  reservationId: string = "";
}

export function convertTablesFromDB(tables: any) {
  var tableList: TableModel[] = [];
  
  if (tables.docs.length > 0) {
    tables.docs.forEach((table: any) => {
      var tempTable: TableModel = new TableModel();
      tempTable.id = table.id;
      tempTable.busy = table.data()["busy"];
      tempTable.capacity = table.data()["capacity"];
      tempTable.number = table.data()["number"];
      tempTable.reservationId = table.data()["reservationId"];
  
      tableList.push(tempTable);
    });
  }

  return tableList;
}

export function convertTableFromDB(tableFromDB: any) {
  var table: TableModel = new TableModel();

  if (tableFromDB) {
    table.id = tableFromDB.id;
    table.busy = tableFromDB.data()["busy"];
    table.capacity = tableFromDB.data()["capacity"];
    table.number = tableFromDB.data()["number"];
    table.reservationId = tableFromDB.data()["reservationId"];
  }

  return table;
}
