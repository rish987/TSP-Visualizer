/* 
 * File:    Tour.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/12/2016
 *
 * A tour over a set of locations that can be animated.
 */
class Tour
{
    /* - PROPERTIES - */
    /* the height and width of the bounding box of a tour */
    public static final float TOUR_HEIGHT = 520;
    public static final float TOUR_WIDTH = 520;

    /* the offset of the components of the tour from the edges of the tour's
     * bounding box */
    private static final float TOUR_OFFSET = 10;

    /* minimum number of locations this tour must have to animate */
    private static final int MIN_LOCS = 2;
    /* - */

    /* - PROPERTY VARIABLES - */
    /* the ordered locations in this tour */
    private final Location[] tour_locs;

    /* the path of this tour */
    private final Path[] tour_path;

    /* the traveler being used for this tour */
    private Traveler tour_traveler = new Traveler ();

    /* the position of this Tour */
    private float x_pos;
    private float y_pos;

    /* the x- and y-position of the shifted origin */
    private float origin_pos_x;
    private float origin_pos_y;
    /* - */

    /* - STATUS VARIABLES - */
    /* is this tour currently animating? */
    boolean animating = false;

    /* index of the next location to visit in the tour */
    private int next_tour_location;

    /* total distance traveled in this tour so far */
    private float total_distance_traveled = 0;

    /* total distance in this tour */
    private float total_distance;

    /* should each location should be displayed as a ranking? */
    private boolean show_rank = false;
    /* - */

    /**
     * Sets up this tour using the given ordered locations, at the position 
     * (0, 0).
     *
     * @param init_tour_locs the the ordered locations in this tour
     */
    public Tour ( Location[] init_tour_locs )
    {
        this( init_tour_locs, 0, 0 );
    }

    /**
     * Sets up this tour using the given ordered locations, in the given
     * position.
     *
     * @param init_tour_locs the the ordered locations in this tour
     * @param init_x_pos the initial x-position of this tour
     * @param init_y_pos the initial y-position of this tour
     */
    public Tour ( Location[] init_tour_locs, float init_x_pos,
         float init_y_pos )
    {
        /* set the locations in this tour */
        tour_locs = init_tour_locs;

        /* set the position of this tour */
        x_pos = init_x_pos;
        y_pos = init_y_pos;

        /* set the position of the origin */
        origin_pos_x = x_pos + TOUR_OFFSET;
        origin_pos_y = y_pos + TOUR_OFFSET;

        /* set the path for this tour */
        tour_path = get_path( tour_locs );

        /* set the origin of each location */
        for ( int loc_ind = 0; loc_ind < tour_locs.length; loc_ind++ )
        {
            /* set origin */
            tour_locs[ loc_ind ].set_origin_pos( origin_pos_x, origin_pos_y );
        }

        /* get the total distance of this tour */
        total_distance = Utilities.get_total_distance( tour_locs );
         
        /* set the origin of each path */
        for ( int path_ind = 0; path_ind < tour_path.length; path_ind++ ) {
            tour_path[ path_ind ].set_origin_pos( origin_pos_x, origin_pos_y );
        }

        /* set the origin of the traveler */
        tour_traveler.set_origin_pos( origin_pos_x, origin_pos_y );
    }

    /**
     * Allow this tour to animate.
     */
    public void animate () 
    {
        /* reset rank display */
        set_show_rank( get_show_rank() );

        /* this tour cannot be animated if there are too few locations */
        if ( tour_locs.length < MIN_LOCS )
        {
            /* do not animate */
            return;
        }

        /* reset the total distance traveled */
        total_distance_traveled = 0;

        /* set all locations to be unvisited, and all paths to be invisible */
        for ( int tour_locs_ind = 0; tour_locs_ind < tour_locs.length;
             tour_locs_ind++ )
        {
            tour_locs[ tour_locs_ind ].set_visited( false );
            tour_path[ tour_locs_ind ].set_show( false );
        }

        /* start from the first location */
        next_tour_location = 1;

        /* the first location has been visited */
        tour_locs[ 0 ].set_visited( true );

        /* travel from the first location to the second */
        tour_traveler.travel( tour_locs[ 0 ], tour_locs[ 1 ] );

        /* allow this tour to animate */
        animating = true;
    }

    /**
     * Redraw this tour.
     */
    public void update () 
    {
        /* draw the bounding box */
        fill( Utilities.FOREGROUND_COLOR );
        stroke( 0 );
        rect( x_pos, y_pos, TOUR_WIDTH, TOUR_HEIGHT );

        /* draw each path */
        for ( int path_ind = 0; path_ind < tour_path.length; path_ind++ )
        {
            tour_path[ path_ind ].update();
        }

        /* this tour is animating */
        if ( animating )
        {
            /* the traveler is traveling */
            if ( tour_traveler.is_traveling() )
            {
                /* update the traveler */
                tour_traveler.update();
            }
            /* the traveler is not traveling, but is touring */
            else
            {
                /* add the distance traveled in the trip just completed
                 * to the total distance */
                total_distance_traveled += tour_traveler.get_trip_distance();

                /* show the tour path */
                tour_path[ next_tour_location - 1 ].set_show( true );

                /* the tour is over */
                if ( next_tour_location == tour_locs.length )
                {
                    /* end the tour */
                    animating = false;
                }
                /* the tour can be completed by traveling back to the first
                 * location */
                else if ( next_tour_location == tour_locs.length - 1 )
                {
                    /* this location has just been visited */
                    tour_locs[ next_tour_location ].set_visited( true );

                    /* indicate that the tour is over */
                    next_tour_location++;
                    
                    /* travel from this location to the first location */
                    tour_traveler.travel( tour_locs[ next_tour_location - 1 ], 
                        tour_locs[ 0 ] );
                }
                /* the tour is not over */
                else
                {
                    /* this location has just been visited */
                    tour_locs[ next_tour_location ].set_visited( true );

                    /* set the next location to visit */
                    next_tour_location++;

                    /* travel from this location to the next location */
                    tour_traveler.travel( tour_locs[ next_tour_location - 1 ], 
                        tour_locs[ next_tour_location  ] );
                }
            }
        }

        /* draw each location */
        for ( int loc_ind = 0; loc_ind < tour_locs.length; loc_ind++ )
        {
            tour_locs[ loc_ind ].update();
        }
    }

    /**
     * Returns the total distance traveled in this tour.
     *
     * @return the total distance traveled in this tour
     */
    public float get_total_distance_traveled () 
    {
        /* the traveler is currenly traveling */
        if ( tour_traveler.is_traveling() )
        {
            /* return the distance traveled in all trips so far including the
             * portion of this trip traveled */
            return total_distance_traveled
                + tour_traveler.get_trip_distance_traveled();
        }
        /* the traveler is not currently traveling */
        else
        {
            /* return the distance traveled in all trips so far */
            return total_distance_traveled;
        }
    }

    /**
     * Sets whether or not each each location should be displayed as a ranking.
     *
     * @param new_show_rank should each location should be displayed as a
     * ranking?
     */
    public void set_show_rank ( boolean new_show_rank )
    {
        /* reset show_rank */
        show_rank = new_show_rank;
        /* go through each location */
        for ( int loc_ind = 0; loc_ind < tour_locs.length; loc_ind++ )
        {
            /* set whether or not this location should be displayed as a
             * ranking */
            tour_locs[ loc_ind ].set_show_rank( show_rank );
        }
    }

    /**
     * Returns whether or not each each location should be displayed as a ranking.
     *
     * @return should each location should be displayed as a ranking?
     */
    public boolean get_show_rank ()
    {
        return show_rank;
    }

    /**
     * Returns a tour path from a tour.
     *
     * @param tour the tour to use to construct the path
     */
    private Path[] get_path ( Location[] tour )
    {
        /* path to return */
        Path[] tour_path = new Path[ tour.length ];

        /* the current location in the tour */
        int tour_loc = 0;

        /* set the paths */
        for( tour_loc = 0; tour_loc < tour.length - 1; tour_loc++ )
        {
            /* each path goes from the current location to the next */
            tour_path[ tour_loc ] = new Path( tour[ tour_loc ],
                 tour[ tour_loc + 1 ] );
        }

        /* there are locations in the tour */
        if ( tour.length != 0 )
        {
            /* set last path */
            tour_path[ tour_loc ] = new Path( tour[ tour_loc ], tour[ 0 ] );
        }

        /* return tour path */
        return tour_path;
    }

    /**
     * Returns the location list.
     *
     * @return the location list
     */
    public Location[] get_location_list () 
    {
        /* return the location list */
        return tour_locs;
    }

    /**
     * Returns the total distance of this tour.
     *
     * @return the total distance of this tour
     */
    public float get_total_distance ()
    {
        return total_distance;
    }

    /**
     * Returns the x-position of the left edge of the locations in this tour.
     */
    public float get_left_edge ()
    {
        return x_pos + Utilities.OFFSET;
    }

    /**
     * Returns the x-position of the right edge of the locations in this tour.
     */
    public float get_right_edge ()
    {
        return x_pos + TOUR_WIDTH - Utilities.OFFSET;
    }

    /**
     * Returns the y-position of the top edge of the locations in this tour.
     */
    public float get_top_edge ()
    {
        return y_pos + Utilities.OFFSET;
    }

    /**
     * Returns the y-position of the bottom edge of the locations in this tour.
     */
    public float get_bottom_edge ()
    {
        return y_pos + TOUR_HEIGHT - Utilities.OFFSET;
    }
}
