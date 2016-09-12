/* 
 * File:    UtilityMethods.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/12/2016
 *
 * Contains various static utility methods.
 */
static class UtilityMethods
{
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

    /**
     * Gets the distance between two locations.
     *
     * @return the distance between two locations
     */
    public static float get_distance_between( Location loc1, Location loc2 )
    {
        /* return distance between loc1 and loc2 */
        return sqrt( pow( loc2.get_x_pos() - loc1.get_x_pos(), 2 )
             + pow( loc2.get_y_pos() - loc1.get_y_pos(), 2 ) );
    }
}

