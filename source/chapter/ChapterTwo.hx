package chapter;

class ChapterTwo
{
    public static var script:Array<Array<Dynamic>> = [
        ["s", "Hewwo im fucking sawyowiiii"], // Line 0
        ["s", "oh hell naw what did monika do"], // Line 1
        ["s", "wait y am i sidewaysssssss"], // Line 2
        ["s", "i'm dissapearing like my father weeee"], // Line 3
        [" ", " "] // ALWAYS HAVE THIS ARRAY EXACTLY LIKE IT IS HERE! THIS TELLS THE GAME THAT THIS IS THE END OF THE CHAPTER!
    ];

    public static function checkLine()
    {
        // this is only for character stuff
        switch (PlayState.curLine)
        {
            case 1:
                PlayState.sayori.rotate(90);
            case 3:
                PlayState.sayori.exitType("swipeToL", 5);
        }
    }
}