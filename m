From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
	servers
Date: Sat, 06 Nov 2004 11:37:32 +1100
Message-ID: <1099701452.3884.30.camel@gaston>
References: <1099448020.900.25.camel@gaston> <20041103032613.GA3677@sci.fi>
	 <1099633776.9260.160.camel@gaston> <20041105093618.GA15762@sci.fi>
	 <Pine.GSO.4.61.0411051052490.15464@waterleaf.sonytel.be>
	 <1099655227.3946.17.camel@gaston>
	 <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQEaY-0000u4-4d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 16:37:54 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CQEaX-0000hT-7I
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 16:37:54 -0800
In-Reply-To: <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Fri, 2004-11-05 at 13:15 +0100, Geert Uytterhoeven wrote:
> On Fri, 5 Nov 2004, Benjamin Herrenschmidt wrote:
> > > But every existing application that uses (shiver) the kernel headers will break
> > > after this change...
> > 
> > Geert, can you explain the whole story please ?
> 
> The story about the +1 or the story about the breakage?
> 
> The Story About The +1
> ----------------------
> Since the VESA levels do not provide a way to blank (`make it black') the
> screen, the +1 is introduced. Hence 0 means unblank, 1 means black screen, 2
> means lowest power save level, and so on...

So why don't we have a nice set of #define's or an enum at least
describing those ? :)
> 
> The Story About The Breakage
> ----------------------------
> Every application that passes VESA_*+1 will break when recompiled, since (most
> of) the VESA_* values are incremented by 1 by the patch.

What patch ? Mine ? It doesn't increment the VESA values, it just clamps
the max. But then, everything seem to be totally inconsistent. So can we
instead define a  set of FB_BLANK_**** values to use and have fbcon
convert VESA->FB_BLANK and FBIOBLANK pass FB_BLANK_* as-is, thus the
drivers would switch/case on those and no more +1 games ?

> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
