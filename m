From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: RFC: Optimizing putcs()
Date: Tue, 6 Aug 2002 22:08:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208062204390.5852-100000@vervain.sonytel.be>
References: <1028584418.556.29.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cAdo-0000xi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 13:09:17 -0700
In-Reply-To: <1028584418.556.29.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 6 Aug 2002, Antonino Daplas wrote:
> With fbcon-accel and the new drawing functions in linux-2.5, console
> performance degraded compared to the linux-2.4 implementation.  This is
> because putcs() has to to do 1 fb_imageblit() per character to be
> drawn.  

Yes, this will be shown badly after I'll have ported amifb to the new
framework, since chip RAM accesses are very slow and we use bitplanes...

> This can be optimized by letting putcs() initially construct the row of
> text to be drawn into an offscreen buffer, then do a single
> fb_imageblit() in the end.  Performance wil increase for several
> reasons:

Yes, this is very nice! I was thinking about passing an array of images to an
fb_imageblit_multiple() or so, but yours may be better.

> For drivers that uses cfb_imageblit or similar, a code such as the one
> below can be inserted during initialization:
> 
> info->pixmap.addr = (unsigned long) kmalloc(BUFFER_SIZE, GFP_KERNEL);
> info->pixmap.size = BUFFER_SIZE;
> info->pixmap.offset = 0;
> info->pixmap.buf_align = 1;
> info->pixmap.scan_align = 1;
> 
> Some benchmarks:
> 
> time cat /usr/src/linux/MAINTAINERS (40K text file)
> mode: 1024x768@8bpp, y-panning disabled.

  [...]

Just for reference, did you run this benchmark on 2.4.x as well?

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
