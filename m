From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 13:21:16 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404271319520.14434@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>
 <1083025364.11575.4.camel@gaston> <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0404271119001.31905@rosencrantz.theboonies.us>
 <1083060616.16475.4.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIQeT-0005oW-L8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 04:21:25 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIQeT-0000f0-3t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 04:21:25 -0700
In-Reply-To: <1083060616.16475.4.camel@gaston>
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
Cc: David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 27 Apr 2004, Benjamin Herrenschmidt wrote:
> > I like the approach.  It sounds like this is the sensible replacement for
> > the vague semantics we have now in var.accel_flags / FB_ACCELF_TEXT.
> >
> > I'm currently running through the radeon code trying to figure who all
> > twiddles var before it gets set to registers and how to rework fbcon to be
> > sensible...
>
> The whole var thing is too messy right now. Especially, the lack of a
> per-VT var right now makes things even more difficult

Agreed, too. It took me much effort to make the console subsystem aware of
different-sized VTs a few years ago, so we should make use of that :-)

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
