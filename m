From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Mirrored Display?
Date: 15 Dec 2002 05:29:33 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039911076.1000.39.camel@localhost.localdomain>
References: <200212131733.42340.kaufmann@sohard.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NJwO-0002GJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Dec 2002 13:35:20 -0800
In-Reply-To: <200212131733.42340.kaufmann@sohard.de>
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
To: Michael Kaufmann <kaufmann@sohard.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2002-12-13 at 23:33, Michael Kaufmann wrote:
> Hello,
> 
> i would like to use a mono LCD with a framebuffer driver.
> 
> I've modified existing drivers, and after a lot of work i now have a clear
> picture on my display. Unfortunately, the complete picture is mirrored.
> The Bootlogo is top/right instead of top/left and the ascii output starts from 
> right to left. 
> 
> Where is the right place to modify this behaviour? 
> I'm also looking for a possibility to rotate the picture.
> Because my videocontroller can emulate 15 grayscales, i'm useing 4bpp.
> 
> It would be very nice, if someone can guide me in the right direction.
> 
Are you using fbcon-cfb4.c to draw the characters?  Is the whole display
mirrored, including individual characters?  If you run an fb-based app
(like fbtest for instance), is the display also mirrored?

If it's the whole display, maybe your hardware supports mirroring (some
hardware with video overlay need this to support YUV formats that are
either vertically or horizontally mirrored).  Maybe it has something
like that.  Otherwise, it will be difficult to correct this without
rewriting practically everything.

Tony



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
