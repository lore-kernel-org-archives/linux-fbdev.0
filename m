From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i810fb: Fix console switch
	regression
Date: Sun, 16 Mar 2008 20:48:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803162042460.7207@anakin>
References: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jayq3-0005Fd-Cp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 12:48:11 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jayq2-0000LG-Od
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 12:48:11 -0700
In-Reply-To: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
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
To: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sun, 16 Mar 2008, Stefan Bauer wrote:
> From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
> 
> Commit eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5 ("fix ! versus & precedence in 
> various places") introduced a regression in console switching when using 
> i810fb. Every 5th to 10th console switch causes 'pixel waste' - the same line 
> of multi-colored pixels repeated over the whole screen.
> This reverts eaa0ff1 for i810_main.c.
> 
> Signed-off-by: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
> Cc: Antonino Daplas <adaplas@pol.net>
> 
> ---
> As I'm not subscribed to the LKML, please CC me, thanks.
> 
> --- linux-2.6/drivers/video/i810/i810_main.c.orig
> +++ linux-2.6/drivers/video/i810/i810_main.c
> @@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info 
> 	struct i810fb_par *par = info->par;
> 	u8 __iomem *mmio = par->mmio_start_virtual;
> 
> -	if (!(par->dev_flags & LOCKUP))
> +	if (!par->dev_flags & LOCKUP)
> 		return -ENXIO;

However, the original expression didn't make sense, as LOCKUP is 8 and
!par->dev_flags is either 0 or 1, so `!par->dev_flags & LOCKUP' is
always 0.

I took a quick look at the usage of the LOCKUP flag. Apparently when a
lock-up is detected, this flag is set, and the driver will fall back to
software operations instead of hardware accelerated operations.

Is it possible the intended code was

	if (par->dev_flags & LOCKUP)
		return -ENXIO;

?

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
