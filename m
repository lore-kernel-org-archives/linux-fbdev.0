From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Mon, 23 Feb 2004 13:44:34 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402231343270.14277@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
 <1077496550.5960.9.camel@gaston> <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be>
 <1077533958.5942.42.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvFZc-0004Of-Ed
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 04:52:36 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvFS0-0007U5-Fg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 04:44:44 -0800
In-Reply-To: <1077533958.5942.42.camel@gaston>
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
Cc: James Simmons <jsimmons@infradead.org>, Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 23 Feb 2004, Benjamin Herrenschmidt wrote:
> > IIRC, there's a big difference between the number of commands you can queue up
> > in the RAGE PRO and earlier chip. Perhaps the queue check always assumes a RAGE
> > PRO?
> >
> > Hope this helps... (No, I didn't look at the code)
>
> The queue check looks for how many entries are free in the queue
> by reading the appropriate register in the chip, I should double
> check the specs to see if that's done correctly though (or compare
> with X, though I do see some artifacts in X here or there, small
> but small drawing errors that let me think that X driver isn't
> perfect neither. At least it doesn't lockup).
>
> Here's the code in atyfb:
>
> static inline void wait_for_fifo(u16 entries, const struct atyfb_par *par)
> {
> 	while ((aty_ld_le32(FIFO_STAT, par) & 0xffff) >
> 	       ((u32) (0x8000 >> entries)));
> }

That's OK, as long as entries <= 15.

Using this register you cannot check for more than 15. There's another register
for that, and the difference between PRO and older is in that second register.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
