From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] kyrofb support
Date: Wed, 14 Jan 2004 13:45:55 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0401141345100.9503@waterleaf.sonytel.be>
References: <20040114013306.GB9515@linux-sh.org> <20040113180926.5fdb0824.akpm@osdl.org>
 <20040114022816.GA9990@linux-sh.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgkPQ-0000mE-4R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 04:46:08 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AgkPP-0000pK-LU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 04:46:07 -0800
In-Reply-To: <20040114022816.GA9990@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Tue, 13 Jan 2004, Paul Mundt wrote:
> On Tue, Jan 13, 2004 at 06:09:26PM -0800, Andrew Morton wrote:
> > In general, what are the fbdev drivers doing here btw?  It's very strange
> > that some core file (fbmem.c) has to "know" about individual card drivers.
> > It should be sufficient for the driver to just register itself with the core
> > at the drivers's module_init() time.
> >
> This is done for device ordering as far as I recall. Devices listed first on
> the command line are numbered first, with the rest coming up in the order that
> they're listed in fb_drivers[].

Indeed. It's there so people can choose which is their primary display, if they
have multiple cards.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
