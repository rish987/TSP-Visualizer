final int WIDTH = 500;
final int HEIGHT = 500;
int num_locs = 10;

Location[] test_tour;

Path[] test_path;

StatusPanel test_panel = new StatusPanel( WIDTH - StatusPanel.STATUS_PANEL_WIDTH, HEIGHT );

Traveler test_trav = new Traveler();

void setup () 
{
    size( 510, 610 );
    background( 240 );

    test_tour = new Location[ num_locs ];

    for ( int i = 0; i < test_tour.length; i++ )
    {
        test_tour[ i ] = new Location( random( WIDTH ), random( HEIGHT ) );
    }

    test_tour = get_greedy_tour( test_tour, 0 );

    test_path = get_path( test_tour );

    test_trav.tour( test_tour, test_path );
}

void draw ()
{
    background( 230 );

    test_trav.update();

    for( int i = 0; i < test_tour.length; i++ )
    {
        test_tour[ i ].update();
    }

    for( int i = 0; i < test_path.length; i++ )
    {
        test_path[ i ].update();
    }

    /* set the total distance traveled in the test panel */
    test_panel.set_total_distance( test_trav.get_total_distance_traveled() );

    /* draw the test panel */
    test_panel.update();
    
    delay( 1 );
}

// get a tour path from a tour
Path[] get_path ( Location[] tour )
{
    // path to return
    Path[] tour_path = new Path[ tour.length ];

    // the current location in the tour
    int tour_loc = 0;
    // set the paths
    for( tour_loc = 0; tour_loc < tour.length - 1; tour_loc++ )
    {
        // each path goes from the current location to the next
        tour_path[ tour_loc ] = new Path( tour[ tour_loc ], tour[ tour_loc + 1 ] );
    }

    // set last path
    tour_path[ tour_loc ] = new Path( tour[ tour_loc ], tour[ 0 ] );

    // return tour path
    return tour_path;
}

// returns a tour that has been optimized for TSP using a greedy algorithm,
// starting at a specified locacation
// unopt_tour: the unoptimized tour
// start_loc: the location in the tour at which to start from
Location[] get_greedy_tour ( Location[] unopt_tour, int start_loc )
{
    // to store the optimized tour
    Location[] opt_tour = new Location[ unopt_tour.length ];

    // to store information regarding whether or not each node has been visited
    boolean[] visited = new boolean[ unopt_tour.length ];

    // the first Location is the specified starting location
    opt_tour[ 0 ] = unopt_tour[ start_loc ];

    // the first location has been visited
    visited[ start_loc ] = true;

    // construct the optimized tour
    for ( int next_loc = 1; next_loc < opt_tour.length; next_loc++ )
    {
        // to store the index of nearest, unvisited location
        int nearest_unvisited_loc = 0;

        // distance to nearest, unvisited location
        float min_dist = Float.MAX_VALUE;

        // check each location to find the next nearest unvisited location
        for ( int check_loc = 0; check_loc < unopt_tour.length; check_loc++ )
        {
            // this location has not been visited yet and the distance to is is
            // less than the distance to nearest_unvisited_loc
            if ( ( !visited[ check_loc ] ) 
                && ( get_distance_between( opt_tour[ next_loc - 1 ], 
                unopt_tour[ check_loc ] ) < min_dist ) )
            {
                // this location is the new nearest_unvisited_loc
                nearest_unvisited_loc = check_loc;
                
                // reset the minimum distance
                min_dist = get_distance_between( opt_tour[ next_loc - 1 ], 
                    unopt_tour[ check_loc ] );
            }
        }

        // visit the nearest, unvisited location
        visited[ nearest_unvisited_loc ] = true;

        // this location is the next location in the tour
        opt_tour[ next_loc ] = unopt_tour[ nearest_unvisited_loc ];
    }

    return opt_tour;
}

// gets the best greedy tour (starting from a location that minimizes distance
// travelled) TODO

// get the distance between two locations
float get_distance_between( Location loc1, Location loc2 )
{
    // return distance between them
    return sqrt( pow( loc2.get_x_pos() - loc1.get_x_pos(), 2 ) + pow( loc2.get_y_pos() - loc1.get_y_pos(), 2 ) );
}

void mouseClicked () 
{
    // check every location
    for ( int i = 0; i < test_tour.length; i++ )
    {
        // this location was clicked
        if ( get_distance_between( new Location( mouseX, mouseY ), test_tour[ i ] ) < ( Location.LOCATION_SIZE / 2 ) )
        {
            test_tour = get_greedy_tour( test_tour, i );

            test_path = get_path( test_tour );

            test_trav.tour( test_tour, test_path );
        }
    }
}
