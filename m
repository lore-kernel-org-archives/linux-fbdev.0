From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] drivers/video/imxfb.c: Fix resource size off by 1
	error
Date: Wed, 8 Jul 2009 14:41:38 +0200
Message-ID: <20090708124138.GR2714@pengutronix.de>
References: <Pine.LNX.4.64.0907042331490.9841@ask.diku.dk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756289AbZGHMmi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0907042331490.9841@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: kernel@pengutronix.de, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Julia,

On Sat, Jul 04, 2009 at 11:32:29PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> In the first case, the change is not semantics-preserving, but
> resource_size is used at the corresponding call to request_mem_region in
> the same function.
> 
> In the second case, the change is semantics-preserving.
> 
> The problem was found using the following semantic patch:
> (http://www.emn.fr/x-info/coccinelle/)
> 
> // <smpl>
> @@
> struct resource *res;
> @@
> 
> - (res->end - res->start) + 1
> + resource_size(res)
> 
> @@
> struct resource *res;
> @@
> 
> - res->end - res->start
> + BAD(resource_size(res))
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  drivers/video/imxfb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -u -p a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> --- a/drivers/video/imxfb.c 2009-04-13 16:04:25.000000000 +0200
> +++ b/drivers/video/imxfb.c 2009-07-04 21:37:48.000000000 +0200
> @@ -754,7 +754,7 @@ failed_map:
>  failed_getclock:
>  	iounmap(fbi->regs);
>  failed_ioremap:
> -	release_mem_region(res->start, res->end - res->start);
> +	release_mem_region(res->start, resource_size(res));
>  failed_req:
>  	kfree(info->pseudo_palette);
>  failed_init:
> @@ -785,7 +785,7 @@ static int __devexit imxfb_remove(struct
>  	framebuffer_release(info);
>  
>  	iounmap(fbi->regs);
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
>  	clk_disable(fbi->clk);
>  	clk_put(fbi->clk);

I already have a patch queued for this issue in imxfb.c

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
