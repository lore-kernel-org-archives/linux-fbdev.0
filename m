From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: kernel: matrox fb - missing files,
 doesn't compile
Date: Sun, 22 Dec 2002 09:44:43 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212220943000.11631-100000@vervain.sonytel.be>
References: <1039974225.1214.59.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Q1jl-0000y0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 22 Dec 2002 00:45:29 -0800
In-Reply-To: <1039974225.1214.59.camel@localhost.localdomain>
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Ariel <aslinux@dsgml.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 15 Dec 2002, Antonino Daplas wrote:
> On Sun, 2002-12-15 at 03:44, Petr Vandrovec wrote:
> > What if I'll decide to paint characters through busmastering? Then
> > I need font data in buffers allocated by pci_alloc_consistent...
> > In the past it was not a win to use busmastering, but now, when
> > upper layers might prepare images much larger than 8x16, it may be 
> > worth of rechecking that...
> 
> True, using kmalloc() to cache a good-sized pixmap is probably not the
> best idea in all cases (in my case, it is best when the pixmap is in
> graphics memory). I submitted a proposal before that allows more
> flexibility: it will let the drivers decide on how it wants the buffers
> allocated, the size of the buffer, specific alignment requirements, or
> if it even actually needs one. Other driver-specific needs can probably
> be added if necessary.

Add address/size fields in fb_info to let the driver tell it already allocated
a suitable buffer? If those are NULL, fbcon can fall back to its own buffer
(e.g. static and fixed 8 kiB buffer).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
