From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] i810fb: Fix console switch regression
Date: Sun, 16 Mar 2008 16:57:22 -0300
Message-ID: <20080316195722.GB31782@khazad-dum.debian.net>
References: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753726AbYCPT5f@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>

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
> 
> 	if (cursor->image.width > 64 || cursor->image.height > 64)
> --

I think you need to add something to that line that avoids someone making
the same change as eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5 some years down
the road.

Might I suggest using "((!par->dev_flags) & LOCKUP)"?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
