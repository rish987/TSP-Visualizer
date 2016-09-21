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

    /* RGB color of ideal starting location for a greedy tour */
    private final int[] IDEAL_COLOR = { 90, 190, 110 };

    /* size of locations */
    public static final float LOCATION_SIZE = 10;

    /* magic ratio that helps center the y-position of ranking text */
    public static final float MAGIC_RATIO = 4.0 / 5.0;

    /* multiplier for text box */
    public static final int MULTIPLIER = 10;
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

    /* is this an ideal starting location for the greedy algorithm? */
    private boolean ideal = false;

    /* the rank of this location */
    private int rank;

    /* should the rank be showing insetead of the circle? */
    private boolean show_rank = false;
    /* - */

    /**
     * Sets up this location at a specified x- and y-position.
     *
     * @param init_x_pos the x-position of this location
     * @param init_y_pos the y-position of this location
     *
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
        /* this location is ideal */ 
        if ( ideal )
        {
            /* reset the color of the location to indicate that it is ideal */
            fill( IDEAL_COLOR[ 0 ], IDEAL_COLOR[ 1 ], IDEAL_COLOR[ 2 ] );
        }
        /* this location is not ideal */ 
        else
        {
            /* reset color */
            fill( loc_color );
        }
        
        /* the rank should be shown */
        if ( show_rank )
        {
            /* set text size */
            textSize( Utilities.TEXT_SIZE );

            /* show the text that dispays rank TODO */
            text( "" + rank, x_pos + origin_pos_x - LOCATION_SIZE / 2, y_pos
                    + origin_pos_y - LOCATION_SIZE * MAGIC_RATIO, 
                    LOCATION_SIZE * MULTIPLIER, LOCATION_SIZE * MULTIPLIER );
        }
        /* the location itself should be shown */
        else
        {
            /* redraw circle */
            ellipse( x_pos + origin_pos_x, y_pos + origin_pos_y, LOCATION_SIZE, 
                LOCATION_SIZE );
        }
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
        /* this is not an ideal starting location for the greedy algorithm */
        if ( !ideal )
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
    }

    /**
     * Sets whether or not this is an ideal starting location for the greedy
     * algorithm.
     *
     * @param new_ideal is this an ideal starting location for the greedy
     * algorithm?
     */
    public void set_ideal ( boolean new_ideal )
    {
        ideal = new_ideal;
    }

    /**
     * Sets the rank of this location
     *
     * @param new_rank the rank of this location
     */
    public void set_rank ( int new_rank )
    {
        rank = new_rank;
    }

    /**
     * Sets whether or not this location should be displayed as a ranking.
     *
     * @param new_show_rank should this location should be displayed as a
     * ranking?
     */
    public void set_show_rank ( boolean new_show_rank )
    {
        show_rank = new_show_rank;
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
