/* 
 * File:    TSPVisualizer.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/11/2016
 *
 * A visualizer of various methods that can be used to find optimal solutions
 * to the Traveling Salesman Problem.
 */
import java.util.Arrays;

/* number of locations in the sample tour */
int num_locs = 10;

/* locations to use for the sample tour */
ArrayList<Location> loc_list = new ArrayList<Location>();

/* rank of each location in loc_list
 * NOTE: parallel to loc_list */
int[] rankings;


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
    size( 540, 700 );

    /* set the title of the window */
    surface.setTitle( "TSP Visualizer" );

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
    loc_list = new ArrayList<Location>( Arrays.asList( get_random_locs( num_locs, 
        Tour.TOUR_WIDTH - 2 * Tour.TOUR_OFFSET,
        Tour.TOUR_HEIGHT - 2 * Tour.TOUR_OFFSET ) ) );

    /* animate the tour */
    reanimate_tour();
}

/**
 * Resets the tour and animates it.
 */
void reanimate_tour ()
{
    /* set the rank of each location */
    Utilities.set_ranks( get_loc_list_array(), true );

    /* find the best greedy tour using loc_list */
    Utilities.find_best_greedy_tour( get_loc_list_array() );

    /* should rank be shown upon reanimation? */
    boolean reanimate_show_rank = false;

    /* a tour was previously played */
    if ( tour != null )
    {
        /* should rank be shown upon reanimation? */
        reanimate_show_rank = tour.get_show_rank();
    }

    /* create the tour */
    tour = new Tour( Utilities.get_best_greedy_tour(), 
        Utilities.OFFSET, Utilities.OFFSET );

    /* reset rank display */
    tour.set_show_rank( reanimate_show_rank );

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
 * Returns the index in loc_list of the location currently under
 * the cursor, or -1 if there is no location.
 *
 * @return the index in loc_list of the location currently under
 * the cursor, or -1 if there is no location
 */
int get_loc_under_cursor ()
{
    /* the locations */
    Location[] arr_loc_list = get_loc_list_array();

    /* check every location */
    for ( int loc_list_ind = 0; loc_list_ind < arr_loc_list.length;
         loc_list_ind++ )
    {
        /* this location was clicked */
        if ( Utilities.get_distance_between( 
            new Location( mouseX - Utilities.OFFSET * 2, 
            mouseY - Utilities.OFFSET * 2 ),
            arr_loc_list[ loc_list_ind ] ) < ( Location.LOCATION_SIZE / 2 ) )
        {
            /* exit so that any overlapping locations that were also clicked do
             * not get returned */
            return loc_list_ind;
        }
    }

    /* no location was found, so return -1 */
    return -1;
}

/**
 * Returns loc_list in array format.
 *
 * @return loc_list in array format
 */
Location[] get_loc_list_array ()
{
    return loc_list.toArray( new Location[ loc_list.size() ] );
}

/**
 * Removes the location from a specified index in loc_list and reanimates the
 * tour.
 */

/**
 * Handles the action of clicking the mouse within the window.
 */
void mouseClicked () 
{
    /* the location that was clicked */
    int loc_clicked = 0;

    /* there is a location under the cursor */
    if ( ( loc_clicked = get_loc_under_cursor() ) != -1 )
    {
        /* should rank be shown upon reanimation? */
        boolean reanimate_show_rank = false;

        /* a tour was previously played */
        if ( tour != null )
        {
            /* should rank be shown upon reanimation? */
            reanimate_show_rank = tour.get_show_rank();
        }

        /* create a tour starting at this location */
        tour = new Tour( Utilities.get_greedy_tour( 
            get_loc_list_array(), loc_clicked ), Utilities.OFFSET,
            Utilities.OFFSET );

        /* reset rank display */
        tour.set_show_rank( reanimate_show_rank );

        /* animate the tour */
        tour.animate();
    }
}

/**
 * Handles the action of typing a key.
 */
void keyTyped () 
{
    /* the 'p' key was typed */
    if ( key == 'p' )
    { /* replay the tour animation */
        tour.animate();
    }
    /* the 'r' key was typed */
    if ( key == 'r' )
    {
        /* animate a random tour */
        animate_random_tour();
    }
    /* the 'a' key was typed */
    if ( key == 'a' )
    {
        /* toggle whether or not rankings are being shown */
        tour.set_show_rank( !tour.get_show_rank() );
    }
    /* the 'd' key was typed */
    if ( key == 'd' )
    {
        /* the index in loc_list of the location that is being deleted */
        int del_loc_ind = 0;

        /* there is a location under the cursor */
        if ( ( del_loc_ind = get_loc_under_cursor() ) != -1 )
        {
            /* remove the location under the cursor */
            loc_list.remove( del_loc_ind );

            /* reanimate the tour */
            reanimate_tour();
        }
    }
    /* the 'c' key was typed */
    if ( key == 'c' )
    {
        /* clear all locations in loc_list */
        loc_list.clear();

        /* reanimate the tour */
        reanimate_tour();
    }
    /* the 'l' key was typed */
    if ( key == 'l' )
    {
        /* the location of the mouse is within the acceptable boundaries */
        if ( ( mouseX > tour.get_left_edge() ) && ( mouseX < tour.get_right_edge() ) &&
             ( mouseY > tour.get_top_edge() ) && ( mouseY < tour.get_bottom_edge() ) )
        {
            /* clear all locations in loc_list */
            loc_list.add( new Location( mouseX - ( 2 * Utilities.OFFSET ), 
                mouseY - ( 2 * Utilities.OFFSET ) ) );

            /* reanimate the tour */
            reanimate_tour();
        }
    }
}
