From: Marek Vasut <marek.vasut@gmail.com>
Date: Sun, 20 Feb 2011 18:47:24 +0000
Subject: Re: [PATCH v2 3/3] ARM: PXA: PXAFB: Fix typo in ypos assignment
Message-Id: <201102201947.24481.marek.vasut@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110217110321.GF24627@n2100.arm.linux.org.uk>
	<1298214147-11578-1-git-send-email-anarsoul@gmail.com>
	<1298214147-11578-3-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1298214147-11578-3-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sunday 20 February 2011 16:02:27 Vasily Khoruzhick wrote:
> Sascha Hauer <s.hauer@pengutronix.de> pointed that
> ypos takes value of xpos due to typo.

Looks good,

Acked-by: Marek Vasut <marek.vasut@gmail.com>
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/pxafb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 54a9ab8..80ea7e6 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -766,7 +766,7 @@ static int overlayfb_check_var(struct fb_var_screeninfo
> *var, int xpos, ypos, pfor, bpp;
> 
>  	xpos = NONSTD_TO_XPOS(var->nonstd);
> -	ypos = NONSTD_TO_XPOS(var->nonstd);
> +	ypos = NONSTD_TO_YPOS(var->nonstd);
>  	pfor = NONSTD_TO_PFOR(var->nonstd);
> 
>  	bpp = pxafb_var_to_bpp(var);
> @@ -864,7 +864,7 @@ static int overlayfb_set_par(struct fb_info *info)
> 
>  	bpp  = pxafb_var_to_bpp(var);
>  	xpos = NONSTD_TO_XPOS(var->nonstd);
> -	ypos = NONSTD_TO_XPOS(var->nonstd);
> +	ypos = NONSTD_TO_YPOS(var->nonstd);
>  	pfor = NONSTD_TO_PFOR(var->nonstd);
> 
>  	ofb->control[0] = OVLxC1_PPL(var->xres) | OVLxC1_LPO(var->yres) |
