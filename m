From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 21 Apr 2004 18:47:16 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404211840040.9207-100000@phoenix.infradead.org>
References: <20040421011412.GA32047@foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGLod-00072O-VX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 10:47:19 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGLoc-000248-MO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 10:47:19 -0700
In-Reply-To: <20040421011412.GA32047@foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>


> Sorry I took a little while to get these out..  Had a bit busier weekend than I
> expected..
> 
> Attached are my patches for the neofb driver.  All of these are against the
> 2.6.5 kernel.  I'm still kinda new to the whole framebuffer subsystem, so if
> I've done something horribly wrong, let me know.  

I have the same chipset. I have the new driver posted at my website. I 
tried your patchs but I had no luck.

> Anyway, the attached patches are as follows:
> 
> neofb.1.copyarea.patch  - Fix copyarea positioning bug

Yeap. Really bad bug. I fixed it in the new driver.

> neofb.2.imageblit.patch - Fix imageblit for color images
> 
>   It looks like the imageblit routine was written with only mono blits in 
>   mind. This patch adds support for color image transfers (Hi Tux!).

I tried this patch. My boot wouldn't boot with this patch. Mind you I 
never got the imageblit to work right.

> neofb.3.16bit.patch     - Misc fixes for 16-bit mode
>
>   Changed the visual reported for 16-bit mode from DirectColor to TrueColor,
>   since we don't support changing the colormap, which means we don't really
>   support DirectColor.  Also changed the palette entries for to be 32 bits 
>   wide even for 16-bit mode because this is what the logo code expects, 
>   and appears to be the correct way of doing things.

I haven't tried this one yet. Geert is this right?

> neofb.4.24bit.patch     - Make 24-bit mode work
> 
>   Added a couple of switch cases needed to make 24-bit mode actually work.
>   The colormap setting code also needed to be moved to be after vgaHWRestore,
>   so that the DAC would be configured properly (8-bit lookups) for 24-bit
>   color before writing to the lookup table.
> 
>   Also, it looks like there's a hardware bug with the NM2200 if you try to do a
>   color-expanded transfer in 24-bit mode and the width of the image is less
>   than 16 pixels wide (The left few pixels of the image seem to get partially
>   wrapped onto the right side.  I haven't tested all cases, actually.. I know
>   it breaks with 8-pixel-width blits), so in that case we just fall back to
>   cfb_imageblit instead.

This can be handled by struct fb_pixmap. It padded image scan_lines to 
what the hardware can handle or is optimized to.
 
> neofb.5.modedb.patch    - Change to use modedb for video mode selection
> 
>   Allows specifying the video mode on the kernel/insmod command line now too.

Also barfed my machine :-( I really like to get i2c support going. Perhaps 
we should ask neomagic for the full specs for this chipset.
 
> neofb.6.blanking.patch  - Add support for DPMS blanking

Ug. The new neofb driver has been moved over to use the new vga core code.
See vgastate.c and vga.h in include/video.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
