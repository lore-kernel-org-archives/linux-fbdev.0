From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit semantic
Date: Fri, 14 Mar 2003 11:40:57 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303141139350.3569-100000@vervain.sonytel.be>
References: <12BA37FB2AC0@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tmdd-0008MW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 02:42:10 -0800
In-Reply-To: <12BA37FB2AC0@vcnet.vc.cvut.cz>
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 14 Mar 2003, Petr Vandrovec wrote:
> On 14 Mar 03 at 10:22, Geert Uytterhoeven wrote:
> > On Thu, 13 Mar 2003, Petr Vandrovec wrote:
> > > Why do you pass image.depth == 16 (or 24 or 32) to fb_imageblit
> > > when logo image is in reality always 8bpp, as quick look at 
> > > cfb_imageblit revealed?
> > 
> > Should indeed be 8.
> > 
> > > Should I just assume that image.depth == 1 means that data are
> > > 1bpp with fgcol/bgcol valid, and all other depths mean 8bpp
> > > input?
> > 
> > This was changed from 1 to 0 in James' latest tree.
> 
> WTF? Color depth 0 means that whole picture is single-color, and
> imageblit degenerates to rectfill in such case. Please, either
> use 'depth' as source image color depth, or do not name it depth.

It's 0 (expand [bf]gcol) to differentiate from 1 (copy monochrome).

Splitting imageblit into separate routines for both operations would be
trivial, though.

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
