From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 50/62] drivers/video/imxfb.c: Remove unnecessary
	semicolons
Date: Mon, 29 Jun 2009 09:12:31 +0200
Message-ID: <20090629071231.GJ31396@pengutronix.de>
References: <cover.1246173664.git.joe@perches.com> <b3809f274f910612520e30bc4a53d4fcb905771c.1246173683.git.joe@perches.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755033AbZF2HNw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3809f274f910612520e30bc4a53d4fcb905771c.1246173683.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sascha Hauer <kernel@pengutronix.de>, linux-fbdev-devel@lists.sourceforge.net

On Sun, Jun 28, 2009 at 09:26:55AM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  drivers/video/imxfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 15a0ee6..89e6f1e 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -677,7 +677,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
>  
>  	fbi->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(fbi->clk)) {
> -		ret = PTR_ERR(fbi->clk);;
> +		ret = PTR_ERR(fbi->clk);
>  		dev_err(&pdev->dev, "unable to get clock: %d\n", ret);
>  		goto failed_getclock;
>  	}
> -- 
> 1.6.3.1.10.g659a0.dirty
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
