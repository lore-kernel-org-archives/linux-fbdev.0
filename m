From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: FB accel capabilities patch
Date: Wed, 19 May 2004 13:14:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405191311360.23702@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
 <20040519030319.1f0e6eec.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQP1U-0008C1-In
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 04:14:08 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQP1T-0005To-Sw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 04:14:08 -0700
In-Reply-To: <20040519030319.1f0e6eec.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@theboonies.us>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Wed, 19 May 2004, Andrew Morton wrote:
> David Eger <eger@theboonies.us> wrote:
> > A month or two ago I noticed that the framebuffer console driver doesn't
> >  know to do proper framebuffer acceleration in Linux 2.6;
>
> For what fbdev operations will acceleration be used?

Text console acceleration (rectangle copy, rectangle fill, bitmap expansion,
panning, y-wrap). These have been in use since ages, but the current 2.6 fbcon
code doesn't use all of it anymore.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
