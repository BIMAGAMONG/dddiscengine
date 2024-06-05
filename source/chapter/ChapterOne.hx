package chapter;

class ChapterOne
{
    public static var script:Array<Array<Dynamic>> = [
        ["m", "Hello chat!"], // Line 0
        ["m", "WOOOHOOOOOOOOO!!!!111"], // Line 1
        ["m", "chat im upside down"], // Line 2
        ["transition", "wipeup"], // Line 3
        ["bgChange", "schoolglitch"], // Line 4
        ["m", "woah a transition and a background change!!!"], // Line 5
        ["m", "chat yall are not ready for this"], // Line 6
        ["m", "bye chat"], // Line 7
        [" ", " "] // ALWAYS HAVE THIS ARRAY EXACTLY LIKE IT IS HERE! THIS TELLS THE GAME THAT THIS IS THE END OF THE CHAPTER!
    ];

    public static function checkLine()
    {
        // this is only for character stuffs
        switch (PlayState.curLine)
        {
            case 1:
                PlayState.monika.rotate(180);
        }
    }
}