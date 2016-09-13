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
    /* the location of the origin */
    private float origin_pos_x;
    private float origin_pos_y;

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
     * Sets the position of this path's origin.
     *
     * @param new_origin_pos_x the x-position of this location's origin
     * @param new_origin_pos_y the y-position of this location's origin
     */
    public void set_origin_pos ( float new_origin_pos_x, 
        float new_origin_pos_y )
    {
        /* set the position of the origin */
        origin_pos_x = new_origin_pos_x;
        origin_pos_y = new_origin_pos_y;
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
            line( start_loc.get_x_pos() + origin_pos_x, 
                start_loc.get_y_pos() + origin_pos_y, 
                end_loc.get_x_pos() + origin_pos_x, 
                end_loc.get_y_pos() + origin_pos_y );

            /* set stroke color back to default (black) */
            stroke( 0 );
        }
    }
}
