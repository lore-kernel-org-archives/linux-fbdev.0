From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK fbdev updates]
Date: Thu, 7 Nov 2002 16:01:06 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211071556020.8121-100000@maxwell.earthlink.net>
References: <1036209978.581.36.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 189vkm-00008A-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Nov 2002 15:08:00 -0800
In-Reply-To: <1036209978.581.36.camel@daplas>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > fbcon_switch has to be rewritten. I'm going threw the process of cleaning
> > up the upper fbcon layer. Its such a mess. Yuck!!!
> Thank goodness for this :)  I was already thinking of adding an 'Option
> Usefbdev' for the xfree86 driver.

There is already a option like that for XFree86.

> > Yes!!! Of course there is the issue is the framebuffer that actual one
> > used for vgacon or is it independent, thinking multihead here.
> >
> I was trying to confirm if vgacon should restore its own state or not.
>
> But this one is neat :)  I added VGA save/restore state routines to
> fb_open() and fb_release().  I was able to boot to a VGA console, fired
> up XFBDev and DirectFB and exited back again to a VGA console.  DirectFB
> came back without problems, XFBDev needed a console reset.

WOW!!! That is way to awesome. I have always wanted to see that actually
work.

> I guess the save/restore state routines will only be needed for graphics
> card with a VGA core.  I think multiple graphics card or multi-head
> systems will not be affected since the driver will only be
> saving/restoring its own hardware anyway.

Correct. One thing I do like is when you insmod a driver it doesn't change
the mode. For example for the neomagic fbdev driver I compiled as a module
and then insmod while using vgacon. Its didn't change the graphics mode so
I was able to find a nasty bug. I could change the video mode once I did a
set_var via userland.

> config FONT_8x16
> 	bool "VGA 8x16 font" if FBCON_FONTS
> 	depends on FB && SGI_NEWPORT_CONSOLE=y
>
> I changed the '&&' operator to '||' in my case.

Applied.

> > > 5.  The cfb_* drawing functions still behave erratically, especially in
> > > emacs.  Geert has made some versions that work correctly for me.  This
> > > was discussed in a thread sometimes ago.
> >
> > Where are the patchs. I like to incorporate them into BK.
> The patch exceeded 40K uncompressed, so here's a link:
>
> http://i810fb.sourceforge.net/draw_ops.diff.gz
>
> The diff is against 2.5.45 plus your fbdev.diff.

It didn't work. Can you send me those files direct. I like to apply them.




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
