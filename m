From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 11:57:16 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404271156250.14434@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>
 <1083025364.11575.4.camel@gaston> <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0404271119001.31905@rosencrantz.theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIPLJ-0005JE-BG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 02:57:33 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIPLI-0007dt-PJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 02:57:32 -0700
In-Reply-To: <Pine.LNX.4.58.0404271119001.31905@rosencrantz.theboonies.us>
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
To: David Eger <eger@theboonies.us>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 27 Apr 2004, David Eger wrote:
> Geert wrote:
> > Indeed. BTW, no comments on my proposal to add fb_fix_screeninfo.capabilities?
>
> referring to his earlier post where he suggested:
> > What we really want to know here is whether redrawing is faster than
> > copying, i.e. whether reading from the frame buffer is fast or slow,
> > and whether fb_copyarea and fb_imageblit are fast or slow.
> >
> > Right now we have in fb_fix_screeninfo:
> >  - [xy]panstep, for hardware panning
> >  - ywrapstep, for hardware ywrap
> >
> > We can add a capability field with some flags that indicates that
> > - fb_copyarea is accelerated or not
> > - fb_imageblit is accelerated or not
> > - fb_write is much faster than fb_read
> > (I don't think it matters much to announce an accelerated fb_fillrect,
> > although we may want to do that for consistency)
> >
> > I chose the above so we have reasonable defaults if the capability field
> > is 0.
> >
> > All other logic can be derived by fbcon from these capabilities, right?
>
> I like the approach.  It sounds like this is the sensible replacement for
> the vague semantics we have now in var.accel_flags / FB_ACCELF_TEXT.

var.accel_flags / FB_ACCELF_TEXT is something different: you need to be able to
disable hardware acceleration before your application touches the accel engine.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
