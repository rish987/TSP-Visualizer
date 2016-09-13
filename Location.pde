/* 
 * File:    Location.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/11/2016
 *
 * An "location" that can be displayed as a circle that changes colors after
 * being visited.
 */
public class Location
{
    /* - PROPERTIES - */
    /* colors of visited and unvisited locations */
    private static final int UNVISITED_COLOR = 200;
    private static final int VISITED_COLOR = 100;

    /* size of locations */
    public static final int LOCATION_SIZE = 10;
    /* - */

    /* - STATUS VARIABLES - */
    /* color of this location */
    private int loc_color = UNVISITED_COLOR;

    /* position of this location */
    private float x_pos;
    private float y_pos;

    /* has this location been visited yet? */
    private boolean visited = false;

    /* the location of the origin */
    private float origin_pos_x;
    private float origin_pos_y;
    /* - */

    /**
     * Sets up this location at a specified x- and y-position.
     *
     * @param init_x_pos the x-position of this location
     * @param init_y_pos the y-position of this location
     */
    public Location ( float init_x_pos, float init_y_pos )
    {
        /* this location has not been visited yet */
        loc_color = UNVISITED_COLOR;

        /* set the position of this location */
        x_pos = init_x_pos;
        y_pos = init_y_pos;
    }

    /**
     * Redraws this location.
     */
    public void update () 
    {
        /* reset color */
        fill( loc_color );

        /* redraw circle */
        ellipse( x_pos + origin_pos_x, y_pos + origin_pos_y, LOCATION_SIZE, 
            LOCATION_SIZE );
    }

    /**
     * Sets the position of this location's origin.
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
     * Sets whether or not this location has been visited.
     *
     * @param new_visited has this location been visited?
     */
    public void set_visited ( boolean new_visited )
    {
        /* reset value of "visited" */
        visited = new_visited;
        
        /* this location has been visited */
        if ( visited )
        {
            /* reset the color of the node to indicate that is has been 
             * visited */
            loc_color = VISITED_COLOR;
        }
        /* this location has not been visited */
        else
        {
            /* reset the color of the node to indicate that is has not been 
             * visited */
            loc_color = UNVISITED_COLOR;
        }
    }

    /**
     * Returns the x-position of this location.
     *
     * @return the x-position of this location
     */
    public float get_x_pos ()
    {
        return x_pos;
    }

    /**
     * Returns the y-position of this location.
     *
     * @return the y-position of this location
     */
    public float get_y_pos ()
    {
        return y_pos;
    }
}
