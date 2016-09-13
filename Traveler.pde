/* 
 * File:    Traveler.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/11/2016
 *
 * A traveler that can be animated to move between locations.
 */
public class Traveler
{
    /* - PROPERTIES - */
    /* size of travelers  */
    private static final float TRAVELER_SIZE = 10;

    /* color of travelers  */
    private static final int TRAVELER_COLOR = 250;
    /* - */

    /* - STATUS VARIABLES - */
    /* the location of the origin */
    private float origin_pos_x;
    private float origin_pos_y;

    /* the x- and y-position of this traveler */
    private float x_pos;
    private float y_pos;

    /* the start and end locations of the traveler */
    private Location start_loc;
    private Location end_loc;

    /* is this traveler currently traveling? */
    private boolean traveling = false;

    /* distance traveled in this trip 
     * NOTE: a trip is defined as moving from one location to another */
    private float trip_distance_traveled = 0;

    /* the distance, and the x- and y-distance the traveler must travel in this
     * trip */
    private float trip_distance;
    private float trip_distance_x;
    private float trip_distance_y;

    /* x- and y-increments in which the traveler must travel to move a */
    /* distance of 1 pixel in the intended direction */
    private float x_inc;
    private float y_inc;

    /* the speed at which the traveler is traveling, in pixels/iteration */
    private float speed = 5;
    /* - */

    /** 
     * Allows this traveler to move from the specified starting location to the 
     * specified ending location.
     *
     * @param new_start_loc the starting location
     * @param new_end_loc the ending location
     */
    public void travel ( Location new_start_loc, Location new_end_loc )
    {
        /* reset trip data */
        trip_distance_traveled = 0;

        /* this traveler is currenly traveling */
        traveling = true;

        /* reset the start and end locations */
        start_loc = new_start_loc;
        end_loc = new_end_loc;

        /* start the traveler at the starting location */
        x_pos = start_loc.get_x_pos();
        y_pos = start_loc.get_y_pos();
        
        /* get trip distances in the x- and y-directions */
        trip_distance_x = end_loc.get_x_pos() - start_loc.get_x_pos();
        trip_distance_y = end_loc.get_y_pos() - start_loc.get_y_pos();
        
        /* calculate the distance to travel in this trip */
        trip_distance = sqrt( pow( trip_distance_x, 2 )
             + pow( trip_distance_y, 2 ) );

        /* get travel increments */
        x_inc = trip_distance_x / trip_distance;
        y_inc = trip_distance_y / trip_distance;
    }

    /**
     * Sets the position of this traveler's origin.
     *
     * @param new_origin_pos_x the x-position of this location's origin
     * @param new_origin_pos_y the y-position of this location's origin
     */
    public void set_origin_pos ( float new_origin_pos_x, 
        float new_origin_pos_y )
    {
        /* set the position of the origin */
        origin_pos_x = new_origin_pos_x;
        origin_pos_y = new_origin_pos_y;
    }

    /** 
     * Updates the postion of this traveler.
     */
    public void update () 
    {
        /* the traveler has not yet traveled the full distance */
        if ( trip_distance_traveled + speed < trip_distance )
        {
            /* update the position of this traveler */
            x_pos += x_inc * speed;
            y_pos += y_inc * speed;

            /* draw line from starting location to traveler */
            line( start_loc.get_x_pos() + origin_pos_x, start_loc.get_y_pos()
                + origin_pos_y, x_pos + origin_pos_x,
                y_pos + origin_pos_y );

            /* set traveler color */
            fill( TRAVELER_COLOR );

            /* draw the traveler */
            ellipse( x_pos + origin_pos_x, y_pos + origin_pos_y, 
                TRAVELER_SIZE, TRAVELER_SIZE );

            /* this traveler has moved */
            trip_distance_traveled += speed;
        }
        /* the traveler has just completed traveling the full distance */
        else
        {
            /* this traveler is no longer traveling */
            traveling = false;

            /* reset trip distance traveled */
            trip_distance_traveled = 0;
        }
    }

    /**
     * Returns whether or not this traveler is traveling.
     *
     * @return is this traveler traveling?
     */
    public boolean is_traveling () 
    {
        return traveling;
    }

    /**
     * Returns the total distance this traveler has traveled in this trip so
     * far.
     *
     * @return the total distance this traveler has traveled in this trip
     */
    public float get_trip_distance_traveled () 
    {
        return trip_distance_traveled;
    }

    /**
     * Returns the total distance this traveler must travel in this trip.
     *
     * @return the total distance this traveler must travel in this trip
     */
    public float get_trip_distance () 
    {
        return trip_distance;
    }
}
