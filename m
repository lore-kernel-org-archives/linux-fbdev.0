From: James Simmons <jsimmons@infradead.org>
Date: Thu, 20 Jan 2011 16:03:37 +0000
Subject: frame buffer on PXA320
Message-Id: <alpine.LFD.2.00.1101201602370.6842@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi!

   I forward this email to the proper list.


Hello,
I have a board Toradex Colibri PXA320 with linux (2.6.31).
Could anybody tell me how can I set up framebuffer for 800x600 24 bits per 
pixel mode?
The picture is blinking on the screen.
With another modes framebuffer works fine, e.g. 16bpp.
There are correct values in LCD controller registers and GPIO pins are set 
well too.

In file "drivers/video/pxafb.c" I found this code:

if (fbi->fb.var.bits_per_pixel >= 16)
                fb_dealloc_cmap(&fbi->fb.cmap);

Why do we deallocate color map in struct fb_info if bits per pixel is more 
than 16?
Thus fb_info.cmap = NULL and I can't use ioctl request FBIOGETCMAP and 
can't play with different color maps.
Or may be it's not a color map issue?

Thanks,
Best regards,
Dennis Semakin.

