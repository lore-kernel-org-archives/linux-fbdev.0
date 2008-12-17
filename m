From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Re: Xorg dies on my deferred I/O fb driver
Date: Wed, 17 Dec 2008 15:50:22 +0100
Message-ID: <20081217145022.GM12994@pruts.nl>
References: <20081217140141.GL12994@pruts.nl>
	<Pine.LNX.4.64.0812171515220.11971@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ico@pruts.nl>) id 1LCxjR-0000zF-Rr
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 14:50:37 +0000
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LCxjN-0002aF-VH for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 14:50:37 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0812171515220.11971@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net



* On 2008-12-17 Geert Uytterhoeven <geert@linux-m68k.org> wrote  :

> On Wed, 17 Dec 2008, Ico Doornekamp wrote:
> > Today I wrote a simple framebuffer driver for a SPI driven LCD display
> > with internal memory, using the deferred I/O framework. The display is
> > capable of grayscale, 384x160 pixels.
> > 
> > My driver resembles the metronomefb driver, and seems to work using
> > write() and mmap() with my own test tools.
> > 
> > The next step would be to run Xorg/fbdev on top, but things don't seem
> > to simple work this way.
> > 
> > Xorg starts and detects te framebuffer driver, but dies with the message
> > 
> >   (EE) FBDEV(0): FBIOPUT_VSCREENINFO succeeded but modified mode
> >   (EE) FBDEV(0): mode initialization failed
> > 
> > I'm kind of stuck here. Any tips on how to solve or debug this one ?
> > 
> > On the bottom of this mail I pasted:
> > 
> > - fbinfo -i output
> > - Xorg log
> > - fb_fix_screeninfoa and fb_var_screeninfo from my driver
> > 
> > Running Xorg 1.4.2 on Linux 2.6.27.4
> 
> I guess your frame buffer device driver supports one single video mode only?

Indeed, good guess.

> There's a bug in Xorg that doesn't like drivers that support one
> single video mode only, and always return that single video mode in
> the FBIOPUT_VSCREENINFO ioctl (cfr. the "FBIOPUT_VSCREENINFO succeeded
> but modified mode" message).
> 
> One fix is to modify your frame buffer device driver to reject all
> modes that are not identical to the single supported mode.

Ok, that's the kind of hint I needed, I'll go steal some code from other
drivers right away.

Thanks,

Ico

-- 
:wq
^X^Cy^K^X^C^C^C^C

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
