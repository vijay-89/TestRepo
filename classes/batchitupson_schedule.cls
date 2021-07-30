global class batchitupson_schedule implements Schedulable {
global void execute(SchedulableContext scMain) {
batchAccountUpdate obj= new batchAccountUpdate();
ID idBatch = Database.executeBatch(obj,100);
}
}