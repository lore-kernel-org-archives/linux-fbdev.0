From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Mar 2012 18:42:11 +0000
Subject: Re: [PATCH] video: pxafb: add clk_prepare/clk_unprepare calls
Message-Id: <4F6A2103.8070609@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331835120.14662.3.camel@flow>
In-Reply-To: <1331835120.14662.3.camel@flow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/15/2012 06:12 PM, Philipp Zabel wrote:
> This patch adds clk_prepare/clk_unprepare calls to the pxafb
> driver by using the helper functions clk_prepare_enable and
> clk_disable_unprepare.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/pxafb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 1d1e4f1..904f839 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -1431,7 +1431,7 @@ static void pxafb_enable_controller(struct pxafb_info *fbi)
>  	pr_debug("reg_lccr3 0x%08x\n", (unsigned int) fbi->reg_lccr3);
>  
>  	/* enable LCD controller clock */
> -	clk_enable(fbi->clk);
> +	clk_prepare_enable(fbi->clk);
>  
>  	if (fbi->lccr0 & LCCR0_LCDT)
>  		return;
> @@ -1471,7 +1471,7 @@ static void pxafb_disable_controller(struct pxafb_info *fbi)
>  	wait_for_completion_timeout(&fbi->disable_done, 200 * HZ / 1000);
>  
>  	/* disable LCD controller clock */
> -	clk_disable(fbi->clk);
> +	clk_disable_unprepare(fbi->clk);
>  }
>  
>  /*

