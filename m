From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 20:03:26 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404281958460.11982@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404281829410.1187-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BItPD-0005N5-NA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 11:03:35 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BItPD-0001A3-97
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 11:03:35 -0700
In-Reply-To: <Pine.LNX.4.44.0404281829410.1187-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 Apr 2004, James Simmons wrote:
> > - Wasted effort in accel engines handling is only useful to fbcon,
> >   nobody needs acceleration to drive a X x Y character matrix
> >   in fbcon.  The argument that hw without a framebuffer will
> >   exist and that's why the accel engine must be used is BS,
> >   the PC, the BIOS and the video framebuffers will never die,
> >   framebuffer exists in the best video cards money can buy
> >   today and it exists in planned cards from major manufacturers
> >   for tomorrow, probably the framebuffer can't be accessed when
> >   the accel engine is being used in forthcoming cards but that
> >   is completely a different story.
>
> I disagree. It's also a performace issue. Even if we use software
> drawing routines the fbcon layer still needs to draw a image, fill
> a region and copy a area. We can't just dump that into fbcon easily.

Indeed. Try to work for a while on an unaccelerated fbcon console and you'll
notice why you want acceleration.

Hardware without a CPU-accessible frame buffer is not the reason, so far those
hardware was not driven by fbcon/fbdev but by their own console drivers (e.g.
Indy Newport and the never merged TI34010 GSP driver).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
