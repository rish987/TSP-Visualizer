/* 
 * File:    StatusPanel.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/11/2016
 *
 * A modifiable panel on which information can be displayed.
 */
class StatusPanel
{
    /* - PROPERTIES - */
    /* the dimensions of a status panel */
    public static final float STATUS_PANEL_WIDTH = Tour.TOUR_WIDTH;
    public static final float STATUS_PANEL_HEIGHT = 150;

    /* offset of text from edges of panel */
    public static final int TEXT_OFFSET = 5;

    /* color of text */
    public static final int TEXT_COLOR = 0;
    /* - */

    /* - STATUS VARIABLES - */
    /* the x- and y-position of the panel */
    private float x_pos;
    private float y_pos;

    /* the total distance traveled */
    private float total_distance = 0;

    /* instructional notes to be printed on the panel */
    private String notes = 
        "Notes:"
        + "\n- all tours optimized using greedy algorithm"
        + "\n- controls: p - replay; r - play new, randomized tour; a - "
        + "toggle rank display mode; d - delete location under cursor; "
        + "c - delete all locations; l - place location under cursor"
        + "\n- click on a location to start a tour from that location"
        + "\n- green location(s): ideal starting location(s) for the greedy algorithm";
    /* - */

    /** 
     * Sets up this panel at a specified location.
     *
     * @param init_x_pos the initial x-position of this panel
     * @param init_y_pos the initial y-position of this panel
     */
    public StatusPanel ( float init_x_pos, float init_y_pos )
    {
        /* set the initial position of this panel */
        x_pos = init_x_pos;
        y_pos = init_y_pos;
    }

    /**
     * Redraws this panel.
     */
    public void update ()
    {
        /* set color */
        fill( Utilities.FOREGROUND_COLOR );

        /* draw the panel */
        rect( x_pos, y_pos, STATUS_PANEL_WIDTH, STATUS_PANEL_HEIGHT );

        /* set text color and size */
        fill( TEXT_COLOR );
        textSize( Utilities.TEXT_SIZE );

        /* draw text */
        text( "Distance travelled: \n" + total_distance + "\n" + notes,
            x_pos + TEXT_OFFSET, y_pos + TEXT_OFFSET,
            STATUS_PANEL_WIDTH - ( TEXT_OFFSET * 2 ), STATUS_PANEL_HEIGHT );
    }

    /**
     * Resets the total distance.
     *
     * @param new_total_distance the new total distance
     */
    public void set_total_distance ( float new_total_distance )
    {
        total_distance = new_total_distance;
    }
}
