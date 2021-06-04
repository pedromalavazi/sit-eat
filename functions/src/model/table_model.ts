export class TableModel {
  busy: boolean = false;
  number: number = 0;
  capacity: number = 0;
  reservationId: string = "";
}

export function convertTablesFromDB(tables: any) {
  var tableList: TableModel[] = [];

  tables.docs.forEach((table: any) => {
    var tempTable: TableModel = new TableModel();
    tempTable.busy = table.data()["busy"];
    tempTable.capacity = table.data()["capacity"];
    tempTable.number = table.data()["number"];
    tempTable.reservationId = table.data()["reservationId"];

    tableList.push(tempTable);
  });

  return tableList;
}
