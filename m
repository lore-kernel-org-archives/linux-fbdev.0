From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit semantic
Date: Mon, 17 Mar 2003 11:31:50 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303171129360.17453-100000@vervain.sonytel.be>
References: <1047855544.1220.79.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18urvm-0004TW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 02:33:22 -0800
In-Reply-To: <1047855544.1220.79.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 17 Mar 2003, Antonino Daplas wrote:
> As Geert said, it's not just trivial, but logical to split fb_imageblit
> into two.

So, are we gonna split it? This will also make hardware acceleration support
more clean. E.g. most sbus drivers do color expansion in hardware, and fall
back to cfb_imageblit() for the logo.

> > OK, so rule is that if depth=0, input is 1bpp with palette in bgcol/fgcol,
> > while if depth != 0, then palette is in info->pseudo_palette ?
> 
> Yes.  You can also say that if image->depth != var->bits_per_pixel, do
> color expansion or reduction, whatever the case may be.

Hmmm... Note that image->depth can be larger than 8, while the image data is
still 8-bit. This is an inconsistency.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
