From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: FB device without console support
Date: Thu, 30 Oct 2003 13:12:30 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310301311580.15545-100000@waterleaf.sonytel.be>
References: <3FA0F7AC.2000600@inaccessnetworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFBfJ-0007tl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 04:12:37 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AFBfI-00012o-MA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 04:12:36 -0800
In-Reply-To: <3FA0F7AC.2000600@inaccessnetworks.com>
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
To: Manousaridis Angelos <amanous@inaccessnetworks.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 30 Oct 2003, Manousaridis Angelos wrote:
> Geert Uytterhoeven wrote:
> > On Thu, 30 Oct 2003, Manousaridis Angelos wrote:
> >>Is it possible with a 2.4.xx kernel?
> >>Upgrading would be a nighmare fom me, I am targeting an embedded platform.
> >  
> > Disable CONFIG_VT_CONSOLE, and the console messages will no longer be printed
> > to the frame buffer. You still have a console though, i.e. you can still print
> > to /dev/ttyX if you want.
> > 
> > If you don't want to provide console drawing operations, just set
> > display->dispsw to &dispsw_dummy.
> > 
> > Gr{oetje,eeting}s,
> 
> I found no dispsw_dummy, do you mean fbcon_dummy?

Yes (I really should look up terms in the sources).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
