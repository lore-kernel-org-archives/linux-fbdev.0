From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] pxafb: add support for overlay1 and
 overlay2 as framebuffer devices
Date: Tue, 23 Dec 2008 14:10:33 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812231354250.17497@anakin>
References: <f17812d70812230247l78bd6010v4fd6c94e49523175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1LF71z-0000OK-1J
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 13:10:39 +0000
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LF71v-0005hV-BO for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 13:10:39 +0000
In-Reply-To: <f17812d70812230247l78bd6010v4fd6c94e49523175@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>

On Tue, 23 Dec 2008, Eric Miao wrote:
> +Overlay Support for PXA27x and later LCD controllers
> +====================================================
> +
> +  PXA27x and later processors support overlay1 and overlay2 on-top of the
> +  base framebuffer (although under-neath the base is also possible). They
> +  support palette and no-palette RGB formats, as well as YUV formats (only
> +  available on overlay2). These overlays have dedicated DMA channels and
> +  behave in a similar way as a framebuffer.
> +
> +  However, there are some differences between these overlay framebuffers
> +  and normal framebuffers, as listed below:
> +
> +  1. overlay can start at a 32-bit word aligned position within the base
> +     framebuffer, which means they have a start (x, y). This information
> +     is encoded into var->nonstd (no, var->xoffset and var->yoffset are
> +     not for such purpose).
> +
> +  2. overlay framebuffer is allocated dynamically according to specified
> +     'struct fb_var_screeninfo', the amount is decided by:
> +
> +        var->xres_virtual * var->yres_virtual * bpp
> +
> +     bpp = 16 -- for RGB565 or RGBT555
> +         = 24 -- for YUV444 packed
> +         = 24 -- for YUV444 planar
> +	 = 16 -- for YUV422 planar (1 pixel = 1 Y + 1/2 Cb + 1/2 Cr)
> +	 = 12 -- for YUV420 planar (1 pixel = 1 Y + 1/4 Cb + 1/4 Cr)
> +
> +     NOTE:
> +
> +     a. overlay does not support panning in x-direction, thus
> +        var->xres_virtual will always be equal to var->xres
> +
> +     b. line length of overlay(s) must be on a 32-bit word boundary,
> +        for YUV planar modes, it is a requirement for the component
> +	with minimum bits per pixel,  e.g. for YUV420, Cr component
> +	for one pixel is actually 2-bits, it means the line length
> +	should be a multiple of 16-pixels
> +
> +     c. starting horizontal position (XPOS) should start on a 32-bit
> +        word boundary, otherwise the fb_check_var() will just fail.
> +
> +     d. the rectangle of the overlay should be within the base plane,
> +        otherwise fail
> +
> +     Applications should follow the sequence below to operate an overlay
> +     framebuffer:
> +
> +         a. open("/dev/fb[1-2]", ...)
> +	 b. ioctl(fd, FBIOGET_VSCREENINFO, ...)
> +	 c. modify 'var' with desired parameters:
> +	    1) var->xres and var->yres
> +	    2) larger var->yres_virtual if more memory is required,
> +	       usually for double-buffering
> +	    3) var->nonstd for starting (x, y) and color format
> +	    4) var->{red, green, blue, transp} if RGB mode is to be used
> +	 d. ioctl(fd, FBIOPUT_VSCREENINFO, ...)
> +	 e. ioctl(fd, FBIOGET_FSCREENINFO, ...)
> +	 f. mmap
> +	 g. ...
> +
> +  3. for YUV planar formats, these are actually not supported within the
> +     framebuffer framework, application has to take care of the offsets
> +     and lengths of each component within the framebuffer.
> +
> +  4. var->nonstd is used to pass starting (x, y) position and color format,
> +     the detailed bit fields are shown below:
> +
> +    31                23  20         10          0
> +     +-----------------+---+----------+----------+
> +     |  ... unused ... |FOR|   XPOS   |   YPOS   |
> +     +-----------------+---+----------+----------+
> +
> +     FOR  - color format, as defined by OVERLAY_FORMAT_* in pxafb.h
> +            0 - RGB
> +	    1 - YUV444 PACKED
> +	    2 - YUV444 PLANAR
> +	    3 - YUV422 PLANAR
> +	    4 - YUR420 PLANAR
> +
> +     XPOS - starting horizontal position
> +     YPOS - starting vertical position

I'm not so fond of this use of .nonstd for specifying the relative position of
(overlay) frame buffers.

What about the (years old) idea of having separate sysfs-based way to configure
relative position, scale, order, and alpha of multiple frame buffer devices?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
