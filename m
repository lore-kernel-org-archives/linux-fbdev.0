From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
 servers
Date: Fri, 5 Nov 2004 16:21:00 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411051619170.15464@waterleaf.sonytel.be>
References: <1099448020.900.25.camel@gaston> <200411052055.17316.adaplas@hotpop.com>
 <Pine.GSO.4.61.0411051357050.15464@waterleaf.sonytel.be>
 <200411052115.07646.adaplas@hotpop.com> <Pine.LNX.4.58L.0411051453110.25345@blysk.ds.pg.gda.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ5tj-0005Mq-Dt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:21:07 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ5ti-0001Sc-2q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:21:07 -0800
In-Reply-To: <Pine.LNX.4.58L.0411051453110.25345@blysk.ds.pg.gda.pl>
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 5 Nov 2004, Maciej W. Rozycki wrote:
> On Fri, 5 Nov 2004, Antonino A. Daplas wrote:
> > > > And make it black is usually done in software (by memsetting the screen
> > > > with the black color).
> > >
> > > Or by setting all color palette registers to black, if available, since
> > > it's cheaper...
> > 
> > Ok. So, if pseudocolor/directcolor, set palette to all black, otherwise memset
> > the screen.
> 
>  Still not there -- some RAMDACs can be asked to do blanking themselves.  

In that case fb_info->fb_ops->fb_blank() should not be NULL and take care of
blanking, so no fallback to software blanking is necessary.

> And there are these interesting implementations like the Bt463 that have a
> palette even though using the truecolor mode.

Doesn't that one do directcolor instead of truecolor?

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
