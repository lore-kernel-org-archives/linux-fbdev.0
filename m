From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: New Permedia2 framebuffer driver.
Date: Wed, 10 Mar 2004 13:32:30 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403101330440.14075@waterleaf.sonytel.be>
References: <1vN2x-8tz-15@gated-at.bofh.it> <1xP9O-6Rm-13@gated-at.bofh.it>
 <404E669E.6010507@olifantasia.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B13A1-0001e5-AD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 04:50:09 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B12sz-0006FH-1Q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 04:32:33 -0800
In-Reply-To: <404E669E.6010507@olifantasia.com>
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
To: Martin <nldudok1@olifantasia.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi Martin,

On Wed, 10 Mar 2004, Martin wrote:
> Geert Uytterhoeven wrote:
> > On Wed, 3 Mar 2004, James Simmons wrote:
> >>This patch fixes the permedia2 framebuffer driver. Currently it doesn't
> >>event compile. This patch only touches the current permedia driver.
> >>Regular patch is valiable at
> >>
> >>http://phoenix.infradead.org/~jsimmons/pm2fb.diff
> >
> >
> > I suggest the following changes:
> >   - Mark FB_PM2 broken on Amiga, until somebody fixes it (pm2fb.c explicitly
> >     tests for CONFIG_PCI right now)
> >   - Always use the standard barrier macros (they do exist on m68k, and map to
> >     barrier())
> >   - Fix set_aperture() on big endian (pm2fb_par->depth doesn't exist)
> >
> Does this mean the permedia2 is only broken on Amiga or on all the
> powerpc platforms?

Its broken on Amiga because the version in 2.6 supports PCI boards only. It may
work on PCI PPCs, don't know.

> Also please tell me if this is the right place for these questions.

linux-fbdev-devel@lists.sourceforge.net is more appropriate

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
