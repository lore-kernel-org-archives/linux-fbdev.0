From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: S3triofb
Date: Mon, 25 Nov 2002 11:40:28 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0211251134250.25405-100000@vervain.sonytel.be>
References: <200211231119.gANBJhk03235@panix3.panix.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18GGfx-0004Hx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Nov 2002 02:41:13 -0800
In-Reply-To: <200211231119.gANBJhk03235@panix3.panix.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jochen Roth <jochen@panix.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 23 Nov 2002, Jochen Roth wrote:
> - Who is the current maintainer for the S3triofb? Maybe I wasn't
>   looking in the right places, but I didn't figure it out. I emailed
>   Peter de Schrijver, who is listed in the driver as author, but I
>   haven't heard back.
> 
> - The current (2.4.19 for me) S3triofb has a workaround in it to
>   reset the PCI BAR0 register to 0xc6000000, with size 64 megs.
>   I a) want to figure out for what model this was necessary to add
>   some sort of fix, and b) this does not make sense to me as the
>   proper address for a 64 meg window wouldn't be 0xc6000000, but
>   something naturally aligned, like 0xc[48]000000. Very weird.

The current S3triofb driver in the mainline kernel tree was meant for the CHRP
LongTrail. It assumes Open Firmware has initialized the chip to a graphics
mode.

You also may want to look at cyberfb, for Amiga CyberVision/64 graphics boards,
which hae a Trio as well.

> - I looked briefly at http://gtf.org/garzik/kernel/files/s3fb/ -- is
>   this code functional? I know, I should just ask Jeff Garzik.

Well, last time I tried, it didn't work on my Trio64V+ :-(

> - I started out wanting to support the V2/DX in my box. Then it occured
>   to me that, hey, I could support all Trio64 and 32 models while I'm
>   at it. Next thing you know, you arrive at s3fb above. OTOH, Trios
>   aren't exactly cutting edge, and S3 is pretty dead these days. Maybe
>   the s3fb above is not in the mainline kernel for a reason? On Intel

The main reason why it's not in the mainline kernel is that we have several (at
least 3) S3Trio fbdevs floating around the net, and AFAIK none is known to work
on all boards.

But I strongly admit it would be a good thin to have generic s3fb support!

>   machines this hardware is probably supported by the vesa drivers, so
>   there it not much incentive from that perspective. What do people here
>   think?

Most older (pre-Savage?) S3 cards don't have VESA 2.0 bioses, so vesafb doesn't
work for those.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
