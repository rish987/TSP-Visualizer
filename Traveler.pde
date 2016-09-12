/* 
 * File:    Traveler.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/11/2016
 *
 * A traveler that moves between locations and can be sent on a tour.
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
    /* the x- and y-position of this traveler */
    private float x_pos;
    private float y_pos;

    /* the start and end locations of the traveler */
    private Location start_loc;
    private Location end_loc;

    /* is this traveler currently traveling? */
    private boolean traveling = false;

    /* is this traveler currently touring? */
    private boolean touring = false;

    /* distance traveled in this trip 
     * NOTE: a trip is defined as moving from one location to another */
    private float trip_distance_traveled = 0;

    /* total distance traveled  */
    private float total_distance_traveled = 0;

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
    private float speed = 3;

    /* locations in this traveler's tour */
    private Location[] tour;

    /* path of this traveler's tour */
    private Path[] tour_path;

    /* index of the next location to visit in the tour */
    private int next_tour_location;
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
     * Allows this traveler to go on a specified tour.
     *
     * @param new_tour the tour this traveler is going on
     * @param new_tour_path the path this traveler will "lay down" as it goes
     * on the tour 
     */
    public void tour ( Location[] new_tour, Path[] new_tour_path )
    {
        /* reset the total distance traveled */
        total_distance_traveled = 0;
        
        /* the tour is too short */
        if ( new_tour.length <= 1 )
        {
            /* do not go on the tour */
            return;
        }

        /* reset all locations on the tour to indicate that they have not been 
         * visited */
        for ( int new_tour_ind = 0; new_tour_ind < new_tour.length;
             new_tour_ind++ )
        {
            new_tour[ new_tour_ind ].set_visited( false );
        }
        
        /* this traveler is now touring  */
        touring = true;

        /* set the tour */
        tour = new_tour;

        /* set the tour path */
        tour_path = new_tour_path;

        /* set the next Location to visit */
        next_tour_location = 1;

        /* the first location has been visited */
        tour[ 0 ].set_visited( true );

        /* travel from the first location to the second */
        travel( tour[ 0 ], tour[ 1 ] );
    }

    /** 
     * Updates the postion of this traveler.
     */
    public void update () 
    {
        /* the traveler is traveling */
        if ( traveling )
        {
            /* the traveler has not yet traveled the full distance */
            if ( trip_distance_traveled + speed < trip_distance )
            {
                /* update the position of this traveler */
                x_pos += x_inc * speed;
                y_pos += y_inc * speed;

                /* draw line from starting location to traveler */
                line( start_loc.get_x_pos(), start_loc.get_y_pos(), 
                    x_pos, y_pos );

                /* set traveler color */
                fill( TRAVELER_COLOR );

                /* draw the traveler */
                ellipse( x_pos, y_pos, TRAVELER_SIZE, TRAVELER_SIZE );

                /* this traveler has moved */
                trip_distance_traveled += speed;
            }
            /* the traveler has just completed traveling the full distance */
            else
            {
                /* this traveler is no longer traveling */
                traveling = false;

                /* add the distance traveled in the trip just completed
                 * to the total distance */
                total_distance_traveled += trip_distance;

                /* reset trip distance traveled */
                trip_distance_traveled = 0;
            }
        }
        /* the traveler is not traveling, but is touring */
        else if ( touring )
        {
            /* show the tour path */
            tour_path[ next_tour_location - 1 ].set_show( true );

            /* the tour is over */
            if ( next_tour_location == tour.length )
            {
                /* end the tour */
                touring = false;
            }
            /* the tour can be completed by traveling back to the first
             * location */
            else if ( next_tour_location == tour.length - 1 )
            {
                /* this location has just been visited */
                tour[ next_tour_location ].set_visited( true );

                /* indicate that the tour is over */
                next_tour_location++;
                
                /* travel from this location to the first location */
                travel( tour[ next_tour_location - 1 ], tour[ 0 ] );
            }
            /* the tour is not over */
            else
            {
                /* this location has just been visited */
                tour[ next_tour_location ].set_visited( true );

                /* set the next location to visit */
                next_tour_location++;

                /* travel from this location to the next location */
                travel( tour[ next_tour_location - 1 ], 
                        tour[ next_tour_location  ] );
            }
        }
    }

    /**
     * Returns the total distance this traveler has traveled in this tour.
     *
     * @return the total distance this traveler has traveled in this tour
     */
    public float get_total_distance_traveled () 
    {
        /* the traveler is currenly traveling */
        if ( traveling )
        {
            /* return the distance traveled in all trips so far including the
             * portion of this trip traveled */
            return total_distance_traveled + trip_distance_traveled;
        }
        /* the traveler is not currently traveling */
        else
        {
            /* return the distance traveled in all trips so far */
            return total_distance_traveled;
        }
    }
}
