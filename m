From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 13:19:47 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404271319210.14434@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>
 <1083025364.11575.4.camel@gaston> <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0404271119001.31905@rosencrantz.theboonies.us>
 <Pine.GSO.4.58.0404271156250.14434@waterleaf.sonytel.be> <1083060569.16473.2.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIQd1-0005U8-I9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 04:19:55 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIQd1-0001Jy-1g
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 04:19:55 -0700
In-Reply-To: <1083060569.16473.2.camel@gaston>
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
Cc: David Eger <eger@theboonies.us>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 27 Apr 2004, Benjamin Herrenschmidt wrote:
> On Tue, 2004-04-27 at 19:57, Geert Uytterhoeven wrote:
> > var.accel_flags / FB_ACCELF_TEXT is something different: you need to be able to
> > disable hardware acceleration before your application touches the accel engine.
>
> That was true in 2.4, I don't think this can apply reasonably well in 2.6.
> In fact, from experience, the var tends to be "lost" easily, I'm not sure
> why exactly.
>
> On the other hand, I tend to think that if you have a KD_TEXT console,
> accel is under fbcon control, if you have a KD_GRAPHICS console, then
> the accel engine is under you control. I don't think any else make any
> sense in fact

You're right, I forgot about that.

> We really need to simplify all of that stuff, it's way too messy at the
> moment.

Agreed.

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
