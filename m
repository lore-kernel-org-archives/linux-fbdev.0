From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: bits_per_pixel query
Date: Wed, 11 Sep 2002 14:43:33 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0209111441180.27524-100000@vervain.sonytel.be>
References: <20020911123718.28335.qmail@webmail26.rediffmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17p6qc-0001kn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Sep 2002 05:43:59 -0700
In-Reply-To: <20020911123718.28335.qmail@webmail26.rediffmail.com>
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
To: Linux PPC <linuxppc@rediffmail.com>
Cc: Antonino Daplas <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 11 Sep 2002, Linux  PPC wrote:
> On Mon, 09 Sep 2002 Antonino Daplas wrote :
> >Just pad the pitch/line_length/stride of the buffer to the next 
> >byte
> >alignment your hardware is capable of.  It is acceptable to have 
> >excess
> >bits/bytes which theoretically your hardware will ignore.
> 
> The padding is at the end of the line_length, or
> at the end of the pixel data? I tried both ways,
> but I'm getting a skewed square, which I draw
> using a user space application.

The padding is at the end of the line.

If fix.line_length != 0, the line length (in bytes) is fix.line_length, and the
padding is fix.line_length-var.xres_virtual*var.bits_per_pixel/8.
If fix.line_length == 0, the line length (in bytes) is
var.xres_virtual*var.bits_per_pixel/8 and there is no padding.
 
> >For static pseudocolor and truecolor, that is true, since 0 is 
> >hardwired
> >to black.  For pseudocolor and directcolor, that depends on how 
> >the
> >DAC/palette is loaded. In most cases, it will produce a black 
> >screen.
> 
> For psuedocolor and direct color, does the pixel
> data, have the index into the colormap or does it
> have actual colors? If it has the index, then the size of the 
> buffer would be lesser: right?

In pseudocolor and directcolor, the pixel data is a colormap index. Pixels
always have a size of var.bits_per_pixel bits.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
In remembrance
www.osdn.com/911/
