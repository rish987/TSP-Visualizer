/* 
 * File:    TSPVisualizer.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/11/2016
 *
 * A visualizer of various methods that can be used to find optimal solutions
 * to the Traveling Salesman Problem.
 */

/* number of locations in the sample tour */
int num_locs = 10;

/* locations to use for the sample tour */
Location[] loc_list;

/* tour to use for the sample tour */
Tour tour;

/* panel on which to display information */
StatusPanel panel;

/**
 * Sets up the program by creating the window and starting a tour.
 */
void setup () 
{
    /* set the size of the window */
    size( 540, 650 );

    /* establish the frame rate */
    frameRate( 100 );

    /* create the status panel */
    panel = new StatusPanel( 
        width - ( StatusPanel.STATUS_PANEL_WIDTH + Utilities.OFFSET ),
        height - ( StatusPanel.STATUS_PANEL_HEIGHT + Utilities.OFFSET ) );

    /* animate a random tour */
    animate_random_tour();
}

/**
 * Animates a random tour.
 */
void animate_random_tour ()
{
    /* get a set of random locations */
    loc_list = get_random_locs( num_locs, 
        Tour.TOUR_WIDTH - 2 * Tour.TOUR_OFFSET,
        Tour.TOUR_HEIGHT - 2 * Tour.TOUR_OFFSET );

    /* color the ideal starting location for the greedy algorithm */
    loc_list[ Utilities.get_best_greedy_tour_ind( loc_list ) ].set_ideal( 
        true );

    /* create the tour */
    tour = new Tour( Utilities.get_best_greedy_tour( loc_list ), 
        Utilities.OFFSET, Utilities.OFFSET );

    /* animate the tour */
    tour.animate();
}

/**
 * Returns a randomized tour within the specified bounds and with the specified
 * number of locations.
 *
 * @param loc_count the number of random locations to generate
 * @param width the width of the bounding box
 * @param height the height of the bounding box
 *
 * @return a randomized tour within the specified bounds and with the specified
 * number of locations
 */
Location[] get_random_locs ( int loc_count, float width, float height )
{
    /* random locations to return */
    Location[] rand_locs = new Location[ loc_count ];

    /* set each location in rand_locs */
    for ( int rand_locs_ind = 0; rand_locs_ind < rand_locs.length;
         rand_locs_ind++ )
    {
        /* get a random location within the specified bounds */
        rand_locs[ rand_locs_ind ] = new Location( random( width ), 
            random( height ) );
    }

    /* return these random locations */
    return rand_locs;
}

/**
 * Draws the components of the visualizer, updating them as needed.
 */
void draw ()
{
    /* draw the background */
    background( Utilities.BACKGROUND_COLOR );

    /* update the tour */
    tour.update();
     
    /* update the total distance on the panel */
    panel.set_total_distance( tour.get_total_distance_traveled() );

    /* update the panel */
    panel.update();
}

/**
 * Handles the action of clicking the mouse within the window.
 */
void mouseClicked () 
{
    /* check every location */
    for ( int i = 0; i < tour.get_location_list().length; i++ )
    {
        /* this location was clicked */
        if ( Utilities.get_distance_between( 
            new Location( mouseX - Utilities.OFFSET * 2, 
            mouseY - Utilities.OFFSET * 2 ),
            tour.get_location_list()[ i ] ) < ( Location.LOCATION_SIZE / 2 ) )
        {
            /* create a tour starting at this location */
            tour = new Tour( Utilities.get_greedy_tour( 
                tour.get_location_list(), i ), Utilities.OFFSET,
                 Utilities.OFFSET );

            /* animate the tour */
            tour.animate();

            /* exit so that any overlapping locations that were also clicked do
             * not animate */
            return;
        }
    }
}

void keyPressed () 
{
    /* the 'p' key was pressed */
    if ( key == 'p' )
    {
        /* replay the tour animation */
        tour.animate();
    }
    /* the 'r' key was pressed */
    if ( key == 'r' )
    {
        /* animate a random tour */
        animate_random_tour();
    }
}

