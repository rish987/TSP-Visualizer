/* 
 * File:    Tour.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/12/2016
 *
 * TODO 
 */
class Tour
{
    /* - PROPERTIES - */
    /* the height and width of the bounding box of a tour */
    private static final float TOUR_HEIGHT = 520;
    private static final float TOUR_WIDTH = 520;

    /* the offset of the components of the tour from the edges of the tour's
     * bounding box, and of the bounding box from the edges of the window */
    private static final float TOUR_OFFSET = 10;

    /* the x- and y-position of the shifted origin */
    private static final float ORIGIN_POS = TOUR_OFFSET * 2;
    /* - */

    /* - PROPERTY VARIABLES - */
    /* the ordered locations in this tour */
    private final Location[] tour_locs;

    /* the traveler being used for this tour */
    private Traveler tour_traveler = new Traveler ();

    /* the position of this Tour */
    private float x_pos;
    private float y_pos;
    /* - */

    /**
     * Sets up this tour using the given ordered locations, in the given
     * position.
     *
     * @param init_tour_locs the the ordered locations in this tour
     * @param init_x_pos the initial x-position of this panel
     * @param init_y_pos the initial y-position of this panel
     */
    public Tour ( Location[] init_tour_locs, float init_x_pos,
         float init_y_pos )
    {
        /* set the locations in this tour */
        tour_locs = init_tour_locs;


    }

    /** 
     * Returns a tour that has been optimized for TSP using a greedy algorithm,
     * starting at a specified location.
     *
     * @param unopt_tour the unoptimized tour
     * @param start_loc the location in the unoptimized tour at which to 
     * start from
     */
    public static Location[] get_greedy_tour ( Location[] unopt_tour, 
        int start_loc )
    {
        /* to store the optimized tour */
        Location[] opt_tour = new Location[ unopt_tour.length ];

        /* to store information regarding whether or not each node has been 
         * visited */
        boolean[] visited = new boolean[ unopt_tour.length ];

        /* the first Location is the specified starting location */
        opt_tour[ 0 ] = unopt_tour[ start_loc ];

        /* the first location has been visited */
        visited[ start_loc ] = true;

        /* construct the optimized tour */
        for ( int next_loc = 1; next_loc < opt_tour.length; next_loc++ )
        {
            /* to store the index of nearest, unvisited location */
            int nearest_unvisited_loc = 0;

            /* distance to nearest, unvisited location */
            float min_dist = Float.MAX_VALUE;

            /* check each location to find the next nearest unvisited 
             * location */
            for ( int check_loc = 0; check_loc < unopt_tour.length; 
                check_loc++ )
            {
                /* this location has not been visited yet and the distance to 
                 * it is less than the distance to nearest_unvisited_loc */
                if ( ( !visited[ check_loc ] ) 
                    && ( get_distance_between( opt_tour[ next_loc - 1 ], 
                    unopt_tour[ check_loc ] ) < min_dist ) )
                {
                    /* this location is the new nearest_unvisited_loc */
                    nearest_unvisited_loc = check_loc;

                    /* reset the minimum distance */
                    min_dist = get_distance_between( opt_tour[ next_loc - 1 ], 
                            unopt_tour[ check_loc ] );
                }
            }

            /* visit the nearest, unvisited location */
            visited[ nearest_unvisited_loc ] = true;

            /* this location is the next location in the tour */
            opt_tour[ next_loc ] = unopt_tour[ nearest_unvisited_loc ];
        }

        /* return the optimized tour */
        return opt_tour;
    }
}
