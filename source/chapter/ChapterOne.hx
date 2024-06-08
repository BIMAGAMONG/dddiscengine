package chapter;

class ChapterOne
{
    public static var script:Array<Array<Dynamic>> = [
        ["m", "Hello chat!"], // Line 0
        ["m", "WOOOHOOOOOOOOO!!!!111"], // Line 1
        ["m", "chat im upside down"], // Line 2
        ["transition", "wipedown"], // Line 3
        ["bgchange", "schoolglitch"], // Line 4
        ["m", "woah a transition and a background change!!!"], // Line 5
        ["m", "chat yall are not ready for this"], // Line 6
        ["m", "bye chat"], // Line 7
        [" ", " "] // ALWAYS HAVE THIS ARRAY EXACTLY LIKE IT IS HERE! THIS TELLS THE GAME THAT THIS IS THE END OF THE CHAPTER!
    ];

    public static function checkLine()
    {
        // this is only for character emotions and other stuff related to characters
        switch (PlayState.curLine)
        {
            case 0:
                PlayState.monika.entranceType("swipeFromL");
            case 2:
                PlayState.monika.rotate(180);
            case 4:
                PlayState.monika.moveTo(100, 100);
        }
    }
}