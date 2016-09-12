/* 
 * File:    Tour.pde
 * Author:  Rishikesh Vaishnav
 * Date:    9/12/2016
 *
 * TODO 
 */
class Tour
{
    /* - PROPERTIES - */
    /* the height and width of the bounding box of a tour */
    private static final float TOUR_HEIGHT = 520;
    private static final float TOUR_WIDTH = 520;

    /* the offset of the components of the tour from the edges of the tour's
     * bounding box */
    private static final float TOUR_OFFSET = 10;
    /* - */

    /* - PROPERTY VARIABLES - */
    /* the ordered locations in this tour */
    private final Location[] tour_locs;

    /* the traveler being used for this tour */
    private Traveler tour_traveler = new Traveler ();

    /* the position of this Tour */
    private float x_pos;
    private float y_pos;

    /* the x- and y-position of the shifted origin */
    private float origin_pos_x;
    private float origin_pos_y;
    /* - */

    /* - STATUS VARIABLES - */
    /* is this tour currently animating? */
    boolean animating = false;
    /* - */

    /**
     * Sets up this tour using the given ordered locations, in the given
     * position.
     *
     * @param init_tour_locs the the ordered locations in this tour
     * @param init_x_pos the initial x-position of this tour
     * @param init_y_pos the initial y-position of this tour
     */
    public Tour ( Location[] init_tour_locs, float init_x_pos,
         float init_y_pos )
    {
        /* set the locations in this tour */
        tour_locs = init_tour_locs;

        /* set the position of this tour */
        x_pos = init_x_pos;
        y_pos = init_y_pos;

        /* set the position of the origin */
        origin_pos_x = x_pos + TOUR_OFFSET;
        origin_pos_y = y_pos + TOUR_OFFSET;
    }

    /**
     * Allow this tour to animate.
     */
    public void animate () 
    {
        /* allow this tour to animate */
        animating = true;
    }
}
