From: Antonino Daplas <adaplas@pol.net>
Subject: Re: 2.5.51 -- rivafb is whacky (characters
	flipped on vertical axis, 640x480 usable area shown inside a higher-res
	area, etc).
Date: 11 Dec 2002 17:49:01 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039610250.1147.95.camel@localhost.localdomain>
References: <3DF6894E.3090802@attbi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18M3a8-0001mI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Dec 2002 01:55:08 -0800
In-Reply-To: <3DF6894E.3090802@attbi.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Miles Lane <miles.lane@attbi.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-12-11 at 05:39, Miles Lane wrote:
> Hi,
> 
> I have tried getting rivafb to work in 2.5.51.  It is much better
> than before (thanks!).  It compiles and sorta works.
> 
> Here are the problems:
> 
> When I run "fbset -a 640x480", I get display that fills
> the screen and looks okay, but most of the characters are
> flipped along the vertical axis, so they are backwards, so that:
> 
> +----		    ----+
> |			|
> +---    becomes	     ---+
> |			|
> |			|
> 
What's the hardware, is it on a big endian machine? I think there's a
typo there (__BIG_ENDIAN__ instead of __BIG_ENDIAN).  This should
produce the "mirroring" effect.

Secondly, a lot of the changes there are for riva128, which may not
apply for all cards. Try doing fbset -accel false/true and see if
there's any effect. Or open linux/video/drivers/riva/fbdev.c, line 277
and comment out the line with the FB_ACCELF_TEXT.  This should force the
hardware to do everything in software.  

> Also, when I boot, the penguin logo looks like it is being rendered
> in about five colors.  In addition, the text is black, except for
That's definitely a color map problem.

> the white underscore cursor, so all I can see is the cursor.
> When the gpm gets loaded, the mouse pointer, instead of showing
> a white rectangle that, when it passes over a character, shows that
> character in reverse-video, shows a colored cursor that always
> contains some character.  The character shown in the mouse cursor 
> changes when it passes over text in the window, but it never shows
> the character it is passing over.
> 
I get this with every framebuffer driver, so this is generic.

> Lastly, when I run "fbset -a 1600x1200", a 640x480 area shows
> a usable console window, but it is embedded in the larger high
> resolution display, like this:
> 
> 	+---------+----------------+
> 	|	  |		   |
> 	|	  |		   |
> 	|	  |		   |
> 	+---------+		   |
> 	|			   |
> 	|			   |
> 	|			   |
> 	|			   |
> 	|			   |
> 	+--------------------------+
> 
> The area outside of the 640x480 boundary is filled with colored
> junk (no characters).
Because changes done via fbset are not passed to fbcon anymore.  So
you'll see the display change, but fbcon still thinks it's still on
640x480.  I guess James will add some support for that via the console.

I'll test it myself too with a riva128 PCI.

Tony



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
