From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 22 Apr 2004 21:57:00 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404222152260.25952-100000@phoenix.infradead.org>
References: <20040422031855.GA19220@foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGlFw-0007hx-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 13:57:12 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGlFt-0000CO-86
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 13:57:11 -0700
In-Reply-To: <20040422031855.GA19220@foogod.com>
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


> On Wed, Apr 21, 2004 at 06:47:16PM +0100, James Simmons wrote:
> > I have the same chipset. I have the new driver posted at my website. I 
> > tried your patchs but I had no luck.
> 
> I wasn't aware of your patches earlier (or where to get them).. I found the URL
> you posted in another message and have just downloaded the diff and will look
> into integrating things..
> 
> What is your LCD resolution, BTW?

1024x768. Its a IBM thinkpad 600X.

> 
> > > neofb.2.imageblit.patch - Fix imageblit for color images
> > > 
> > >   It looks like the imageblit routine was written with only mono blits in 
> > >   mind. This patch adds support for color image transfers (Hi Tux!).
> > 
> > I tried this patch. My boot wouldn't boot with this patch. Mind you I 
> > never got the imageblit to work right.
> 
> Could you be a little more specific?
> 
> Were you applying this to a stock kernel or to your patched driver?  What
> exactly happened when you tried it?  You were booting in 8-bit color mode, I
> assume?

Patched driver. I manually applied your patches. I start in 8 bpp mode. 
Nothing appeared on the screen.

> > This can be handled by struct fb_pixmap. It padded image scan_lines to 
> > what the hardware can handle or is optimized to.
> 
> Ok, I'll take a look at this.. I was planning on going back and investigating
> this further anyway.  Initially I was just concentrating on getting working
> functionality.

Okay. Cool We can work on a solution for this problem.
 
> > > neofb.5.modedb.patch    - Change to use modedb for video mode selection
> > > 
> > >   Allows specifying the video mode on the kernel/insmod command line now too.
> > 
> > Also barfed my machine :-( I really like to get i2c support going. Perhaps 
> > we should ask neomagic for the full specs for this chipset.
> 
> Hmm.. again, what does "barfed" mean, exactly?  Did you try specifying
> different video modes on the command line?

Blank screen.

> > > neofb.6.blanking.patch  - Add support for DPMS blanking
> > 
> > Ug. The new neofb driver has been moved over to use the new vga core code.
> > See vgastate.c and vga.h in include/video.
> 
> Ah, ok.. I'll make the appropriate adjustmen
> 
> -alex
> 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
