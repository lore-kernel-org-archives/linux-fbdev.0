From: Alex Stewart <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Wed, 21 Apr 2004 20:18:55 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040422031855.GA19220@foogod.com>
References: <20040421011412.GA32047@foogod.com> <Pine.LNX.4.44.0404211840040.9207-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGUpE-000372-T0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 20:24:32 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGUkw-0008Si-JL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 20:20:06 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404211840040.9207-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, Apr 21, 2004 at 06:47:16PM +0100, James Simmons wrote:
> I have the same chipset. I have the new driver posted at my website. I 
> tried your patchs but I had no luck.

I wasn't aware of your patches earlier (or where to get them).. I found the URL
you posted in another message and have just downloaded the diff and will look
into integrating things..

What is your LCD resolution, BTW?

> > neofb.2.imageblit.patch - Fix imageblit for color images
> > 
> >   It looks like the imageblit routine was written with only mono blits in 
> >   mind. This patch adds support for color image transfers (Hi Tux!).
> 
> I tried this patch. My boot wouldn't boot with this patch. Mind you I 
> never got the imageblit to work right.

Could you be a little more specific?

Were you applying this to a stock kernel or to your patched driver?  What
exactly happened when you tried it?  You were booting in 8-bit color mode, I
assume?

> >   Also, it looks like there's a hardware bug with the NM2200 if you try to do a
> >   color-expanded transfer in 24-bit mode and the width of the image is less
> >   than 16 pixels wide (The left few pixels of the image seem to get partially
> >   wrapped onto the right side.  I haven't tested all cases, actually.. I know
> >   it breaks with 8-pixel-width blits), so in that case we just fall back to
> >   cfb_imageblit instead.
> 
> This can be handled by struct fb_pixmap. It padded image scan_lines to 
> what the hardware can handle or is optimized to.

Ok, I'll take a look at this.. I was planning on going back and investigating
this further anyway.  Initially I was just concentrating on getting working
functionality.

> > neofb.5.modedb.patch    - Change to use modedb for video mode selection
> > 
> >   Allows specifying the video mode on the kernel/insmod command line now too.
> 
> Also barfed my machine :-( I really like to get i2c support going. Perhaps 
> we should ask neomagic for the full specs for this chipset.

Hmm.. again, what does "barfed" mean, exactly?  Did you try specifying
different video modes on the command line?

> > neofb.6.blanking.patch  - Add support for DPMS blanking
> 
> Ug. The new neofb driver has been moved over to use the new vga core code.
> See vgastate.c and vga.h in include/video.

Ah, ok.. I'll make the appropriate adjustments.

-alex


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
