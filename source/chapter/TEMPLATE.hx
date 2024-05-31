package chapter;

class ChapterOne
{
    /* You have to add comments so you can keep track of which line is which. Yes it may be a bummer,
    but unfortunately I have no other idea how to implement the dialogue system. */
    
    public static var script:Array<Array<String>> = [
        /* the first string in the array is in charge of what dialogue box should load, 
        the second string is the dialogue itself.*/
        ["m", "TEXT"], // Line 0
        ["m", "TEXT 2"], // Line 1
        [" ", " "] // ALWAYS HAVE THIS ARRAY WITH EMPTY STRINGS! THIS TELLS THE GAME THAT THIS IS THE END OF THE CHAPTER!
    ];
}