From: James Simmons <jsimmons@infradead.org>
Subject: Re: ioremap problem on highmem
Date: Tue, 14 Oct 2003 18:23:59 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310141811320.20831-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0310141031320.8202-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9Sty-0007gK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 10:24:06 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A9Stx-0001l3-L3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Oct 2003 10:24:06 -0700
In-Reply-To: <Pine.GSO.4.21.0310141031320.8202-100000@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Another approach: on fully-accelerated drivers, you don't need the ioremap(),
> so there's no problem.

  Absolete agree. The only problem is fb_read and fb_write. What if we use 
the imageblit function? The only thing is we have to do between 1 and 3 
blits to the screen. The 2nd and 3rd blit is for the single pixel high 
line at the top and bottom of image blit.
  Another issue is hardware cursors often take a chunk of framebuffer 
space to draw a image. That space has to be off screen otherwise the 
cursor would show up at the bottom of the screen. I remember asking this 
question before about ioremapping the cursor area seperate from the 
framebuffer.

> On non-accelerated drivers, you need the ioremap(), but usually unaccelerated
> hardware is old and has only a few MiB of graphics memory anyway, so there's no
> problem.

Yeap. 

> On partially-accelerated drivers, we can limit the amount of graphics memory
> that's ioremapped(), and thus limit the (virtual) screen size. The remaining
> problem here is that user space may want to know about the full graphics memory
> size, while fbcon cannot handle that.

   Yes!!! First of all we should only map whole screen sizes. If the 
screen is at 640x480 then we should only allow 480, 960, 1440 size virtual y 
resolutions. What would be nice is to see a surface api.	



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
