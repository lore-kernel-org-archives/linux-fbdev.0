From: Miles Lane <miles.lane@attbi.com>
Subject: Re: 2.5.51 -- rivafb is whacky (characters flipped on vertical axis,
 640x480 usable area shown inside a higher-res area, etc).
Date: Tue, 10 Dec 2002 22:10:29 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DF6D6D5.5060902@attbi.com>
References: <Pine.LNX.4.33.0212102136050.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from rwcrmhc52.attbi.com ([216.148.227.88])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18M04y-0002b7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Dec 2002 22:10:44 -0800
In-Reply-To: <Pine.LNX.4.33.0212102136050.2617-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

James, I appreciate all your hard work.  I hope my bug report
isn't too upsetting for you.  I think you are making great progress.
It is also a shame that so much of the driver porting has fallen
on your shoulders.  If I were a programmer.  I'd help, but my skills
are in software testing, for the most part.

All the best,
	Miles

James Simmons wrote:
>>I have tried getting rivafb to work in 2.5.51.  It is much better
>>than before (thanks!).  It compiles and sorta works.
> 
> 
> Ug. Now that several drivers compile now I get bug reports :-( I'm getting
> alot of positive feedback as well as one negative source.
> 
> 
>>Here are the problems:
>>
>>When I run "fbset -a 640x480", I get display that fills
>>the screen and looks okay, but most of the characters are
>>flipped along the vertical axis, so they are backwards, so that:
>>
>>+----		    ----+
>>|			|
>>+---    becomes	     ---+
>>|			|
>>|			|
> 
> 
> Okay. That is weird. I have this card so I will give it a try.
> 
> 
>>Also, when I boot, the penguin logo looks like it is being rendered
>>in about five colors.
> 
> 
> Yipes. Imageblit sounds broken.
> 
> 
>>In addition, the text is black, except for
>>the white underscore cursor, so all I can see is the cursor.
> 
> 
> I noticed this. The color palette is for some reason messed up.
> 
> 
>>When the gpm gets loaded, the mouse pointer, instead of showing
>>a white rectangle that, when it passes over a character, shows that
>>character in reverse-video, shows a colored cursor that always
>>contains some character.  The character shown in the mouse cursor
>>changes when it passes over text in the window, but it never shows
>>the character it is passing over.
> 
> 
> Same things. Color palette is messed up.
> 
> 
>>Lastly, when I run "fbset -a 1600x1200", a 640x480 area shows
>>a usable console window, but it is embedded in the larger high
>>resolution display, like this:
>>
>>	+---------+----------------+
>>	|	  |		   |
>>	|	  |		   |
>>	|	  |		   |
>>	+---------+		   |
>>	|			   |
>>	|			   |
>>	|			   |
>>	|			   |
>>	|			   |
>>	+--------------------------+
>>
>>The area outside of the 640x480 boundary is filled with colored
>>junk (no characters).
>>
>>Any ideas?
> 
> 
> Yeap. I migrated changing the console from /dev/fb to actually using the
> tty layer. I haven't merged those changes yet but you will be able to do a
> 
> stty -f /dev/ttyX 80 col 50 row
> 
> and change the video mode.
> 
> So I didn't plan to push so soon but I kept getting emails about various
> drivers being broken. So I did this push to make more drivers work.
> Unfortuenly I sent a watered down fbcon system.
> 
> 
> 
> 
> 
> 




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
