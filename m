From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev upstream
Date: Tue, 6 Jan 2004 11:08:02 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0401061107350.5485@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0401060049180.7347-100000@phoenix.infradead.org>
 <1073351006.780.200.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ado89-0007FH-5C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 02:08:09 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ado88-0003E3-LN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 02:08:08 -0800
In-Reply-To: <1073351006.780.200.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 6 Jan 2004, Benjamin Herrenschmidt wrote:
> On Tue, 2004-01-06 at 11:51, James Simmons wrote:
> > > Of course, that means we'll have to update more drivers, and platforms
> > > with fixed display, like embedded etc... will need some way to deal
> > > with that properly in their drivers.
> >
> > Fixed screen size drivers should provide there own modedb.
>
> Or just single mode... currently drivers don't export a modedb, they
> keep one internally and do the validation... though it would make sense
> to expose a modedb to userland, so we can have some nice GUI tools
> showing you the available modes :) It would make sense for MacOnLinux
> too which currently rely on the user to setup the list of modes
> available to MacOS.

And how to export it? Sysfs again, I guess...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
