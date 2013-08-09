package procedures;


import java.lang.Math;
import java.lang.Double;
import org.voltdb.*;
import org.voltdb.types.TimestampType;


public class AddLocation extends VoltProcedure {

    public double calcDistance(double latA, double longA, double latB, double longB)
    {
        double theDistance = (Math.sin(Math.toRadians(latA)) *
                              Math.sin(Math.toRadians(latB)) +
                              Math.cos(Math.toRadians(latA)) *
                              Math.cos(Math.toRadians(latB)) *
                              Math.cos(Math.toRadians(longA - longB)));

        return (Math.toDegrees(Math.acos(theDistance))) * 69.09; // in miles
    }

    public final SQLStmt getDevice = new SQLStmt(
        "SELECT * FROM devices WHERE id = ?;");

    public final SQLStmt newLocation = new SQLStmt(
        "INSERT INTO device_location VALUES (?,?,?,?);");

    public VoltTable[] run(int id,
                           TimestampType ts,
                           double new_lat,
                           double new_long
                           ) throws VoltAbortException {

        // get device record and insert new location
        voltQueueSQL(getDevice,id);
        voltQueueSQL(newLocation,id,ts,new_lat,new_long);
        
        return voltExecuteSQL();


        // if has_geofence, calculate distance from home

        // if inside_geofence and distance from home > fence_radius, generate exit event, update device

        // if not inside_geofence and distance from home < fence_radius, generate entry event, update device


        // calculate new location fence status

        // optionally insert a new geofence event

        // insert new location with fence_status


    }
}
