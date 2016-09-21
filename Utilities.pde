/* 
 * File:    Utilities.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/12/2016
 *
 * Contains various static utility methods and constants.
 */
static class Utilities
{
    /* offset of components within the window */
    public static final float OFFSET = 10;

    /* background and foreground colors */
    public static final int BACKGROUND_COLOR = 230;
    public static final int FOREGROUND_COLOR = 240;

    /* font size of text */
    public static final int TEXT_SIZE = 11;

    /* the optimized tour */
    public static Location[] opt_tour;


    /* index of the ideal starting location of a greedy tour */
    public static int min_ind = 0;


    /** 
     * Returns a tour that has been optimized for TSP using a greedy algorithm,
     * starting at a specified location.
     *
     * @param unopt_tour the unoptimized tour
     * @param start_loc the location in the unoptimized tour at which to 
     * start from
     *
     * @return the optimized tour
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
     * Finds a tour that has been optimized for TSP using a greedy algorithm,
     * starting at a location that minimizes the total distance traveled.
     *
     * @param unopt_tour the unoptimized tour
     */
    public static void find_best_greedy_tour ( Location[] unopt_tour )
    {
        /* the minimum total distance achieved so far */
        float min_dist = Float.MAX_VALUE;

        /* to store the optimized tour */
        opt_tour = new Location[ unopt_tour.length ];

        /* iterate through each location in unopt_tour */
        for ( int unopt_ind = 0; unopt_ind < unopt_tour.length; unopt_ind++ )
        {
            /* optimized tour starting at unopt_ind */
            Location[] this_opt = get_greedy_tour( unopt_tour, unopt_ind );

            /* the total distance of this optimized tour */
            float this_opt_dist = get_total_distance( this_opt );

            /* the total distace of this tour is less than min_dist */
            if ( this_opt_dist < min_dist )
            {
                /* this is the new min_dist */
                min_dist = this_opt_dist;
                min_ind = unopt_ind;

                /* this is the new opt_tour */
                opt_tour = this_opt;
            }
        }
    }

    /**
     * Returns an array containing the rank of each location in a given set of
     * locations, with regards to the length of the greedy algorithm as
     * initialized from that location.
     *
     * @param locs the locations to rank
     *
     * @return an array parallel to locs that contains the rank of each
     * locatino in locs
     */
    public static int[] get_rank ( Location[] locs )
    {
        /* to store the ranks */
        int[] ranks = new int[ locs.length ];

        /* to store the lengths of the greedy tours starting from each location
         * NOTE: parallel to locs */
        float[] lengths = new float[ locs.length ];

        /* go through each location */
        for ( int locs_ind = 0; locs_ind < locs.length; locs_ind++ )
        {
            /* store the length of the greedy tour starting from this location */
            lengths[ locs_ind ] = get_total_distance( get_greedy_tour( locs, locs_ind ) );
        }

        /* go through each location */
        for ( int locs_ind = 0; locs_ind < locs.length; locs_ind++ )
        {
            /* this rank is initially 1 */
            ranks[ locs_ind ] = 1;

            /* go through each location again */
            for ( int sub_locs_ind = 0; sub_locs_ind < locs.length; sub_locs_ind++ )
            {
                /* this location's length is less than the length of the
                 * location that is being ranked and the two locations are not
                 * the same */
                if ( ( locs_ind != sub_locs_ind )
                    && ( lengths[ locs_ind ] > lengths[ sub_locs_ind ] ) )
                {
                    /* the rank increases by 1 */
                    ranks[ locs_ind ]++;
                }
            }
        }

        /* return the ranked locations */
        return ranks;
    }

    /**
     * Sets the ranks of a given set of locations.
     *
     * @param locs the locations whose ranks will be set
     * @param color_ideal should ideal locations be colored?
     */
    public static void set_ranks ( Location[] locs, boolean color_ideal )
    {
        /* to store the rank of each location */
        int[] ranks = get_rank( locs );

        /* go through the locations in locs */
        for ( int locs_ind = 0; locs_ind < locs.length; locs_ind++ )
        {
            /* set the rank of this location */
            locs[ locs_ind ].set_rank( ranks[ locs_ind ] );

            /* this location is not ideal by default */
            locs[ locs_ind ].set_ideal( false );

            /* ideal locations should be colored and this is an ideal location */
            if ( color_ideal && ranks[ locs_ind ] == 1 )
            {
                /* color the ideal starting location for the greedy algorithm */
                locs[ locs_ind ].set_ideal( true );
            }
        }
    }

    /** 
     * Returns a tour that has been optimized for TSP using a greedy algorithm,
     * starting at a location that minimizes the total distance traveled.
     *
     * @return the optimized tour
     */
    public static Location[] get_best_greedy_tour ()
    {
        /* return the optimized tour */
        return opt_tour;
    }

    /** 
     * Returns the index of the starting location in a tour that has been
     * optimized for TSP using a greedy algorithm, starting at a location that
     * minimizes the total distance traveled.
     *
     * @return the index of the starting location of the optimized tour
     */
    public static int get_best_greedy_tour_ind ()
    {
        /* return the index */
        return min_ind;
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

    /**
     * Returns the total distance in a tour.
     *
     * @param tour the locations in the tour to get the total distance of
     *
     * @return the total distance in the tour
     */
    public static float get_total_distance ( Location[] tour )
    {
        /* the total distance in this tour */
        float total_distance = 0;

        /* iterate through every location in the tour */
        for ( int tour_ind = 0; tour_ind < tour.length; tour_ind++ )
        {
            /* this location is not the last location */
            if ( tour_ind < tour.length - 1 )
            {
                /* add the distance to the next location to
                 * total_distance */
                total_distance += Utilities.get_distance_between( 
                    tour[ tour_ind ], tour[ tour_ind + 1 ] );
            }
            /* this location is the last location */
            else
            {
                /* add the distance to the first location to
                 * total_distance */
                total_distance += Utilities.get_distance_between( 
                    tour[ tour_ind ], tour[ 0 ] );
            }
        }

        /* return the total distance */
        return total_distance;
    }
}

