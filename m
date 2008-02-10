From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: framebuffer questions
Date: Sun, 10 Feb 2008 12:11:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802101210040.31187@anakin>
References: <p06230914c3d3bdda5250@[192.168.9.5]>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOA5o-0000WM-VF for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 03:11:29 -0800
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JOA5n-0001k3-EJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 03:11:28 -0800
In-Reply-To: <p06230914c3d3bdda5250@[192.168.9.5]>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Scott D. Davilla" <davilla@4pi.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 9 Feb 2008, Scott D. Davilla wrote:
> 1) "info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev)" is used to 
> allocate memory for the framebuffer info structure (struct fb_info 
> *info).
> 
> struct fb_info is greater than 16 * sizeof(u32) so it seems this 
> should be "info = framebuffer_alloc(sizeof(struct fb_info), 
> &dev->dev)" or imacfb is going to be read/writing beyond what was 
> allocated. Side note efifb.c has this same code as it was derived 
> from imacfb.

That's OK. `sizeof(u32) * 16' is the amount of extra private memory used by
the driver, in addition to sizeof(struct fb_info).

> 3) imacfb (and efifb) do not any removal routines for unloading the 
> module. So what happens when X11 takes over? Should there be an 
> removal routine for unloading? The console video buffer is still 
> mapped (screen_base). How does X11 know not to use this area? What 
> does X11 do regarding the console framebuffer when it runs and it is 
> does not unlaod the console module, how does it avoid using the 
> console mapped video memory?

X and imacfb will coexist and use the same memory.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
