From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
 servers
Date: Fri, 5 Nov 2004 13:58:07 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411051357050.15464@waterleaf.sonytel.be>
References: <1099448020.900.25.camel@gaston> <1099655227.3946.17.camel@gaston>
 <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
 <200411052055.17316.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ3fQ-0006cd-0g
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 04:58:12 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ3fO-0005yl-Nq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 04:58:11 -0800
In-Reply-To: <200411052055.17316.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 5 Nov 2004, Antonino A. Daplas wrote:
> On Friday 05 November 2004 20:15, Geert Uytterhoeven wrote:
> > On Fri, 5 Nov 2004, Benjamin Herrenschmidt wrote:
> > > > But every existing application that uses (shiver) the kernel headers
> > > > will break after this change...
> > > Geert, can you explain the whole story please ?
> >
> > The story about the +1 or the story about the breakage?
> >
> > The Story About The +1
> > ----------------------
> > Since the VESA levels do not provide a way to blank (`make it black') the
> > screen, the +1 is introduced. Hence 0 means unblank, 1 means black screen,
> > 2 means lowest power save level, and so on...
> 
> And make it black is usually done in software (by memsetting the screen with
> the black color).  

Or by setting all color palette registers to black, if available, since it's
cheaper...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
