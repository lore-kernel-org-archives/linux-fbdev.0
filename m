From: Miles Lane <miles.lane@attbi.com>
Subject: 2.5.51 -- rivafb is whacky (characters flipped on vertical axis,
 640x480 usable area shown inside a higher-res area, etc).
Date: Tue, 10 Dec 2002 16:39:42 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DF6894E.3090802@attbi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from rwcrmhc51.attbi.com ([204.127.198.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Luui-0000mK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Dec 2002 16:39:48 -0800
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
To: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net

Hi,

I have tried getting rivafb to work in 2.5.51.  It is much better
than before (thanks!).  It compiles and sorta works.

Here are the problems:

When I run "fbset -a 640x480", I get display that fills
the screen and looks okay, but most of the characters are
flipped along the vertical axis, so they are backwards, so that:

+----		    ----+
|			|
+---    becomes	     ---+
|			|
|			|

Also, when I boot, the penguin logo looks like it is being rendered
in about five colors.  In addition, the text is black, except for
the white underscore cursor, so all I can see is the cursor.
When the gpm gets loaded, the mouse pointer, instead of showing
a white rectangle that, when it passes over a character, shows that
character in reverse-video, shows a colored cursor that always
contains some character.  The character shown in the mouse cursor 
changes when it passes over text in the window, but it never shows
the character it is passing over.

Lastly, when I run "fbset -a 1600x1200", a 640x480 area shows
a usable console window, but it is embedded in the larger high
resolution display, like this:

	+---------+----------------+
	|	  |		   |
	|	  |		   |
	|	  |		   |
	+---------+		   |
	|			   |
	|			   |
	|			   |
	|			   |
	|			   |
	+--------------------------+

The area outside of the 640x480 boundary is filled with colored
junk (no characters).

Any ideas?

	Miles



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
