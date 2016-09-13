/* offset of components from edge of screen */
final int OFFSET = 10;

/* number of locations in the tour */
int num_locs = 300;

/* panel on which to display information */
StatusPanel panel;

/* locations to use for a tour */
Location[] loc_list;

/* tour to use */
Tour tour;

void setup () 
{
    frameRate( 10000 );
    size( 540, 650 );

    panel = new StatusPanel( 
        width - ( StatusPanel.STATUS_PANEL_WIDTH + Utilities.OFFSET ),
        height - ( StatusPanel.STATUS_PANEL_HEIGHT + Utilities.OFFSET ) );

    loc_list = new Location[ num_locs ];

    for ( int i = 0; i < loc_list.length; i++ )
    {
        loc_list[ i ] = new Location(
             random( Tour.TOUR_WIDTH - ( 2 * Tour.TOUR_OFFSET ) ),
             random( Tour.TOUR_HEIGHT - ( 2 * Tour.TOUR_OFFSET ) ) );
    }

    /*  */
    tour = new Tour( Utilities.get_greedy_tour( loc_list, 0 ), 
        Utilities.OFFSET, Utilities.OFFSET );

    tour.animate();
}

void draw ()
{
    background( Utilities.BACKGROUND_COLOR );

    /* update the tour */
    tour.update();
     
    /* panel.set_total_distance */
    panel.set_total_distance( tour.get_total_distance_traveled() );

    /* update the test panel */
    panel.update();
}

/* TODO
void mouseClicked () 
{
    /* check every location
    for ( int i = 0; i < test_tour.length; i++ )
    {
        // this location was clicked
        if ( get_distance_between( new Location( mouseX, mouseY ), test_tour[ i ] ) < ( Location.LOCATION_SIZE / 2 ) )
        {
            test_tour = get_greedy_tour( test_tour, i );

            test_path = get_path( test_tour );

            test_trav.tour( test_tour, test_path );

            return;
        }
    }
}
*/
