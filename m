From: Andrey Utkin <andrey.krieger.utkin@gmail.com>
Date: Sat, 24 Dec 2011 15:54:50 +0000
Subject: Need advice on performant text-mode output API
Message-Id: <CANZNk82YxiFQZVmgtQY0jp=uutEZ5_2Ur-WKg25mQeZzU3S3XA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi. I develop the program that visualizes disk checking process.
Similarly to known DOS program, MHDD.
To get the idea, you can find screencasts of its usage on Youtube.
Or look at my program's screenshot:
http://cloud.github.com/downloads/krieger-od/whdd/whdd_screenshot5.png
So i need to update big zone at left, and stats in top right corner.
The point is that it can be ~1000 blocks processed per second,
although it is ok to render them each Nth time, like at each 10-50
blocks processed.
Currently i use ncurses, and its performance is unacceptable, the
screen blinks awfully, because it prints whole screen of chars on
refresh.

I ask for directing me to any sufficiently performant libs/API, to
replace ncurses.
It would be ok, and even nice, if it is plain text mode (80x25, 16
colors), without any overhead of representing my chars as graphical
points.
It would be _very_ nice, if that API provide 'windows' model in terms
of ncurses, to work with rectangular pieces.
No OS portability is required. Linux only is sufficient.
Terminal emulator support is of course not required, although i'm
interested: is it possible to have.

I've found some project - directfb, but i'm not sure if it fits best
for my purpose. It seems to be focused on rich graphic rendering
possibilities. I need stupid, but fast text mode. Similar thing about
SDL.

Any help is appreciated. Thanks.

-- 
Andrey Utkin
