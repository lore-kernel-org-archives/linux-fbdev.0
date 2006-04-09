From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [RFC] Source format change for drawing functions
Date: Sun, 09 Apr 2006 21:29:07 +0800
Message-ID: <44390C23.8060808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FSZyk-0005dt-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Apr 2006 06:29:22 -0700
Received: from pproxy.gmail.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FSZyh-0003tF-Qo
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Apr 2006 06:29:22 -0700
Received: by pproxy.gmail.com with SMTP id i49so878224pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Apr 2006 06:29:18 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi people,

Currently, the drawing functions of the framebuffer devices accepts either an
index to the pseudo_palette (truecolor, directcolor) or an index to the
clut (the rest of the visuals) as the source color.  It has distinct
advantages in that the upper layer (fbcon) need not convert the console colors
to framebuffer format, and makes writing to the framebuffer quite fast.

However, it has certain disadvantages:
- we are restricted to 16 colors only, or with hacks, 256, as in the logo
drawing code
- most drivers need to keep a pseudo_palette which rightly belongs to fbcon,
not the drivers
- the drawing functions are basically useless outside fbcon/fbdev

Therefore, I'm proposing that we change the source format so we can take
advantage of the full range of colors offered by a particular visual while
keeping clients (mainly fbcon) free from the hassle of color conversion.

To implement this:

1. Separate fb_setcolreg() into two functions:

   a. fb_setcolreg() - writes the color components to the hardware clut

   b. fb_get_pixel() - returns a u32 value which is the raw framebuffer format
   given red, green, blue, and transparency components.  The returned value
   can be directly written to the framebuffer.  Basically, this is the part of
   the fb_setcolreg() function that writes entries to the pseudo_palette, but
   it returns the value instead.

   Doing the above should be very simple. In pseudocode, from:

static int xxxfb_setcolreg(...)
{
	write_to_dac()
	pseudo_palette(regno) = red | green | blue | transp;
	return 0;
}

to

static int xxxfb_setcolreg(...)
{
	write_to_dac()
	return 0;
}

static u32 xxxfb_get_pixel(...)
	u32 pixel   = red | green | blue | transp;
	return pixel;
}

2. For drivers that implements fb_get_pixel(), the pseudo_palette will become
   unused, thus there is no need to allocate memory for this.  (fbcon will
   instead maintain the pseudo_palette. And once all drivers are converted we
   can remove the pointer from struct fb_info.)

3. Convert drawing functions to accept source format in ARGB8888
   Truecolor. Drawing functions will use fb_get_pixel() to convert ARGB8888
   into a value which can be directly written to the framebuffer or fed to the
   accelerator engine.
 
   The advantage of doing this is that the drawing functions become usable
   outside of fbdev/fbcon.  It also makes displaying an image to the
   framebuffer easy.  As long as the bitmap is in ARGB8888 (or monochrome),
   this can be fed to the driver and it should display properly regardless of
   the current visual.

   The disadvantage is we do on-the-fly format conversions, so fbcon will slow
   down a litte. Not very noticeable except for the speed freaks.  

   If speed is of the essence, we can instead use source in raw
   framebuffer format. This will be very fast, but this will require that
   clients know how to do the conversion.  fbcon can use fb_get_pixel() to do
   the conversion, so it won't be a problem.

I have a working implementation in my private tree using ARGB8888 as the
source format with several commonly used drivers already converted and
working. There won't be breakage for drivers that do not implement
fb_get_pixel() as the code that uses the index to the pseudo_palette is still
in place. 
  
Comments? I may send this to akpm for testing unless there are violent
objections.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
