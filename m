From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] i810fb: Fix console switch
	regression
Date: Mon, 17 Mar 2008 20:48:12 -0700
Message-ID: <20080317204812.2c3e3754.akpm@linux-foundation.org>
References: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
	<Pine.LNX.4.64.0803162042460.7207@anakin>
	<200803170920.33626.stefan.bauer@cs.tu-chemnitz.de>
	<200803171641.10750.stefan.bauer@cs.tu-chemnitz.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbSoT-00063b-IX for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 20:48:33 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JbSoS-0002mh-A5
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 20:48:33 -0700
In-Reply-To: <200803171641.10750.stefan.bauer@cs.tu-chemnitz.de>
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
Cc: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Mon, 17 Mar 2008 16:41:10 +0100 Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de> wrote:

> I'm sorry for the spaces in the second patch, here's a clean one with tabs.
> 
> ---
> From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
> 
> Since 4c7ffe0b9f7f40bd818fe3af51342f64c483908e ("fbdev: prevent drivers that 
> have hardware cursors from calling software cursor code") every call of 
> i810fb_cursor fails with -ENXIO because of a incorrect "!".
> 
> This hasn't striked until eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5 ("fix ! 
> versus & precedence in various places") surrounded the expression with 
> braces, so that the intended behavior was inverted. That caused 'pixel 
> waste' - the same line of multi-colored pixels repeated over the whole 
> screen - during console switch.
> 
> This switches back to the original pre-4c7ffe0 behavior.
> 
> Signed-off-by: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Antonino Daplas <adaplas@pol.net>
> 
> --- linux-2.6/drivers/video/i810/i810_main.c.orig
> +++ linux-2.6/drivers/video/i810/i810_main.c
> @@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info 
>  	struct i810fb_par *par = info->par;
>  	u8 __iomem *mmio = par->mmio_start_virtual;
>  
> -	if (!(par->dev_flags & LOCKUP))
> +	if (par->dev_flags & LOCKUP)
>  		return -ENXIO;
>  
>  	if (cursor->image.width > 64 || cursor->image.height > 64)

Can you please confirm that this actually fixes the bug?  That wasn't clear.

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
