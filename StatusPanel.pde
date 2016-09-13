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
    public static final int STATUS_PANEL_WIDTH = 200;
    public static final int STATUS_PANEL_HEIGHT = 100;

    /* font size of text */
    public static final int TEXT_SIZE = 13;

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
        textSize( TEXT_SIZE );

        /* draw distance travelled */
        text( "Distance travelled: \n" + total_distance,
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
