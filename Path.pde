/* 
 * File:    Path.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/11/2016
 *
 * A path (line) that connects two locations.
 */
class Path
{
    /* - PROPERTIES - */
    /* path color */
    private static final int PATH_COLOR = 100;
    /* - */

    /* - STATUS VARIABLES - */
    /* the start and end locations of this path */
    private Location start_loc;
    private Location end_loc;

    /* should this path be shown? */
    private boolean show = false;
    /* - */

    /**
     * Sets up this path connecting the specified location.
     *
     * @param init_start_loc the start location of this path
     * @param init_end_loc the end location of this path
     */
    public Path ( Location init_start_loc, Location init_end_loc )
    {
        /* set the start and end locations */
        start_loc = init_start_loc;
        end_loc = init_end_loc;
    }

    /**
     * Sets whether or not this path should be shown 
     *
     * @param new_show should this path be shown?
     */
    public void set_show ( boolean new_show )
    {
        show = new_show;
    }

    /**
     * Redraws this path 
     */
    public void update () 
    {
        /* this path should be shown */
        if ( show )
        {
            /* set path color */
            stroke( PATH_COLOR );

            /* draw the path */
            line( start_loc.get_x_pos(), start_loc.get_y_pos(), 
                end_loc.get_x_pos(), end_loc.get_y_pos() );

            /* set stroke color back to default (black) */
            stroke( 0 );
        }
    }
}
