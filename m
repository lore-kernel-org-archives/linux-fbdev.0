From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbutils
Date: Mon, 22 Dec 2003 17:21:06 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0312221718380.838@waterleaf.sonytel.be>
References: <3FE649BF.30501@undead.cc> <200312222342.15265.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYSny-0006bz-DK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 08:21:14 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYSnx-0005oF-S2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 08:21:14 -0800
In-Reply-To: <200312222342.15265.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, John Zielinski <grim@undead.cc>

On Mon, 22 Dec 2003, Alexander Kern wrote:
> Am Montag, 22. Dezember 2003 02:32 schrieb John Zielinski:
> > Here's a patch to get fbutils from the CVS working if anyone else wants
> > to play around with them.

Thanks John!

> > John
> Have you ./configure for it ? I'm wonder, that this package does not have
> classic build system.

I started fbutils in 1999, but I never finished it.

In fact I never thought anyone would finish it ;-)

> P.S. You spoked also about program named "fbtest". Where I can find it?

CVS module fbtest in linux-fbdev CVS at SourceForge, next to fbutils.

> I have implement accelerated imageblt for mach64. It works good for boot logo
> and console.

Nice!

> "make menuconfig" works also good, but "mc" completely sucks.

That may be a generic fbcon bug...

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
